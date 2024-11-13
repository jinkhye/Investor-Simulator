import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/models/chart_model.dart';
import 'package:investor_simulator/models/forex_model.dart';
import 'package:investor_simulator/models/stockchart_model.dart';

class ForexProvider with ChangeNotifier {
  List<Result> _stocks = [];
  bool _isLoadingStocks = false;
  bool _hasError = false;
  String _errorMessage = '';
  bool _isLoadingChartData = false;
  bool _hasChartError = false;
  List<ChartResult>? _itemChart;
  List<ChartModel>? _chartModel = [];
  String _days = 'W';
  String api = dotenv.env['APIDOJO'] ?? '';

  List<Result> get stocks => _stocks;
  bool get isLoadingStocks => _isLoadingStocks;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  bool get isLoadingChartData => _isLoadingChartData;
  bool get hasChartError => _hasChartError;
  List<ChartResult>? get itemChart => _itemChart;
  List<ChartModel>? get chartModel => _chartModel;
  String get days => _days;

  late Timer _timer;

  ForexProvider() {
    fetchStocks();
    // Start the timer when the provider is initialized
    _timer = Timer.periodic(const Duration(minutes: 10), (_) {
      fetchStocks();
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the provider is disposed
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchStocks() async {
    _isLoadingStocks = true;
    _hasError = false;
    _errorMessage = '';

    try {
      final response = await http.get(
        Uri.parse(
          'https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/v2/get-quotes?region=US&symbols=EURUSD=X%2CUSDJPY=X%2CGBPUSD=X%2CMYR=X%2CEURMYR=X%2CSGDMYR=X%2CUSDCHF=X%2CAUDUSD=X%2CUSDCAD=X%2CNZDUSD=X%2CEURJPY=X%2CGBPJPY=X%2CEURGBP=X',
        ),
        headers: {
          'X-RapidAPI-Host': 'apidojo-yahoo-finance-v1.p.rapidapi.com',
          'X-RapidAPI-Key': api,
        },
      );
      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final ForexModel responseData = forexModelFromJson(decodedResponse);
        _stocks = responseData.quoteResponse.result;
      } else {
        _hasError = true;
        _errorMessage =
            'Error ${response.statusCode}: ${json.decode(response.body)['error']}';
      }
    } catch (error) {
      _hasError = true;
      _errorMessage =
          'Error: $error.\n\nAttention this Api is free, so you cannot send multiple requests per second, please wait and try again later.';
    }

    _isLoadingStocks = false;

    notifyListeners(); // Notify listeners that data fetching is complete
  }

  Future<void> fetchChartData(String? symbol) async {
    String apiDay = getApiDay();

    _isLoadingChartData = true;
    _hasChartError = false;
    _errorMessage = '';

    String url =
        'https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/v3/get-chart?interval=60m&symbol=$symbol&range=$apiDay&region=US&includePrePost=true&includeAdjustedClose=true';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'X-RapidAPI-Host': 'apidojo-yahoo-finance-v1.p.rapidapi.com',
          'X-RapidAPI-Key': api,
        },
      );
      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final StocksChartModel responseData =
            stocksChartModelFromJson(decodedResponse);
        _itemChart = responseData.chart.result;
        notifyListeners();
      } else {
        _hasChartError = true;
        _errorMessage =
            'Error ${response.statusCode}: ${json.decode(response.body)['error']}';
      }
    } catch (error) {
      _hasChartError = true;
      _errorMessage =
          'Error: $error.\n\nAttention this Api is free, so you cannot send multiple requests per second, please wait and try again later.';
    }

    convertStockChartModelsToChartModels();

    _isLoadingChartData = false;
    notifyListeners();
  }

  void emptyChart() {
    _itemChart = null; // Set itemChart to null
  }

  void convertStockChartModelsToChartModels() {
    List<ChartModel> chartModels = [];
    if (_itemChart != null && _itemChart!.isNotEmpty) {
      var result = _itemChart![0];
      for (var i = 0; i < result.timestamp.length; i++) {
        var timestamp = result.timestamp[i];
        if (result.indicators.quote.isNotEmpty) {
          var quote = result.indicators.quote[0];
          chartModels.add(ChartModel(
            time: timestamp,
            open: quote.open.isNotEmpty ? quote.open[i] : null,
            high: quote.high.isNotEmpty ? quote.high[i] : null,
            low: quote.low.isNotEmpty ? quote.low[i] : null,
            close: quote.close.isNotEmpty ? quote.close[i] : null,
          ));
        } else {
          // ignore: avoid_print
          print("Quote data is not available");
        }
      }
    }
    _chartModel = chartModels;
    notifyListeners();
  }

  String getApiDay() {
    switch (_days) {
      case 'D':
        return '1d';
      case 'W':
        return '5d';
      case 'M':
        return '1mo';
      case '3M':
        return '3mo';
      case '6M':
        return '6mo';
      case 'Y':
        return '1y';
      default:
        return '5d';
    }
  }

  void setDays(String txt) {
    _days = txt;
    notifyListeners();
  }

  Color getDayColour(String txt) {
    if (txt == _days) {
      return darkPurple;
    } else {
      return white;
    }
  }

  Color getTextDayColour(String txt) {
    if (txt == _days) {
      return white;
    } else {
      return darkPurple;
    }
  }
}
