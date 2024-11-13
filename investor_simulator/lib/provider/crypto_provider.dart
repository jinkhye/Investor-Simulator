import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/models/chart_model.dart';
import 'package:investor_simulator/models/crypto_model.dart';
import 'dart:convert';

class CryptoProvider extends ChangeNotifier {
  List<CoinModel> _cryptocurrencies = [];
  bool _isLoadingCryptocurrencies =
      false; // Separate loading state for cryptocurrencies
  bool _isLoadingChartData = false; // Separate loading state for chart data
  bool _hasError = false;
  bool _hasChartError = false;
  String _errorMessage = '';
  List<ChartModel>? _itemChart; // Declare itemChart as a nullable list
  String _days = 'W';
  String api = dotenv.env['COINGECKO'] ?? '';

  List<CoinModel> get cryptocurrencies => _cryptocurrencies;
  bool get isLoadingCryptocurrencies => _isLoadingCryptocurrencies;
  bool get isLoadingChartData => _isLoadingChartData;
  bool get hasError => _hasError;
  bool get hasChartError => _hasChartError;
  String get errorMessage => _errorMessage;
  List<ChartModel>? get itemChart => _itemChart; // Getter for itemChart
  String get days => _days;

  late Timer _timer;

  CryptoProvider() {
    fetchCryptocurrencies(); // Fetch cryptocurrencies when the provider is initialized
    // Start the timer when the provider is initialized
    _timer = Timer.periodic(const Duration(minutes: 10), (_) {
      fetchCryptocurrencies();
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the provider is disposed
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchCryptocurrencies() async {
    _isLoadingCryptocurrencies = true; // Set loading state for cryptocurrencies
    _hasError = false;
    _errorMessage = '';

    try {
      final response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=25&page=1&sparkline=true&x_cg_demo_api_key=$api'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _cryptocurrencies = data.map((e) => CoinModel.fromJson(e)).toList();
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

    _isLoadingCryptocurrencies =
        false; // Reset loading state for cryptocurrencies

    notifyListeners();
  }

  Future<void> fetchChartData(String coinId) async {
    int apiDay = getApiDay();

    _isLoadingChartData = true;
    _hasChartError = false;
    _errorMessage = '';

    String url =
        'https://api.coingecko.com/api/v3/coins/$coinId/ohlc?vs_currency=usd&days=$apiDay&x_cg_demo_api_key=CG-9KLBqzTjoFnEW9aWkqXrKmNW';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<ChartModel> chartData =
            responseData.map((data) => ChartModel.fromJson(data)).toList();

        _itemChart = chartData; // Update the private variable
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

    _isLoadingChartData = false;
    notifyListeners();
  }

  void emptyChart() {
    _itemChart = null; // Set itemChart to null
  }

  int getApiDay() {
    switch (_days) {
      case 'D':
        return 1;
      case 'W':
        return 7;
      case 'M':
        return 30;
      case '3M':
        return 90;
      case '6M':
        return 180;
      case 'Y':
        return 365;
      default:
        return 7;
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
