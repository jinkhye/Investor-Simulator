import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/models/chart_model.dart';
import 'package:investor_simulator/models/stockchart_model.dart';
import 'package:investor_simulator/models/stocks_model.dart';

class StocksProvider with ChangeNotifier {
  List<Result> _stocks = [];
  bool _isLoadingStocks = false;
  bool _hasError = false;
  String _errorMessage = '';
  bool _isLoadingChartData = false;
  bool _hasChartError = false;
  List<ChartResult>? _itemChart;
  List<ChartModel>? _chartModel = [];
  String _days = 'W';
  String api = '40d7312818mshddd6877a4da2e17p190b63jsncfe0a925f21a';

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

  StocksProvider() {
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
          'https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/v2/get-quotes?region=US&symbols=AAPL%2C6033.KL%2CTSLA%2C4707.KL%2CMETA%2CBABA%2CAMZN%2CCVX%2C5225.KL%2CMCD%2CPG%2CNFLX%2C1295.KL%2CBA%2C1023.KL%2CMETA%2CPFE%2C5168.KL%2C1155.KL%2CNVDA%2CWMT%2C7113.KL%2CV%2C6888.KL%2CMSFT%2CJNJ%2CHD%2CKO%2CJPM%2CGOOGL%2C%2CT%2CXOM%2CDIS',
        ),
        headers: {
          'X-RapidAPI-Host': 'apidojo-yahoo-finance-v1.p.rapidapi.com',
          'X-RapidAPI-Key': api,
        },
      );
      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final StocksModel responseData = stocksModelFromJson(decodedResponse);
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
