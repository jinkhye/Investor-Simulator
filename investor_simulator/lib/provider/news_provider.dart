import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:investor_simulator/models/news_details_model.dart';
import 'package:investor_simulator/models/news_model.dart' as n;

class NewsProvider with ChangeNotifier {
  List<n.Stream> _news = [];
  List<NewsDetails> _newsDetails = [];
  bool _isLoadingNews = false;
  bool _isLoadingDetails = false;
  bool _hasError = false;
  bool _hasErrorDetails = false;
  String _errorMessage = '';
  String api = '1651139c27msh71996520d0ed192p1eb3b8jsn7c67cea4d8db';

  List<n.Stream> get news => _news;
  List<NewsDetails> get newsDetails => _newsDetails;
  bool get isLoadingNews => _isLoadingNews;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  bool get isLoadingDetails => _isLoadingDetails;
  bool get hasErrorDetails => _hasErrorDetails;

  late Timer _timer;

  NewsProvider() {
    fetchNews();
    // Start the timer when the provider is initialized
    _timer = Timer.periodic(const Duration(minutes: 100), (_) {
      fetchNews();
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the provider is disposed
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchNews() async {
    _isLoadingNews = true;
    _hasError = false;
    _errorMessage = '';

    try {
      final response = await http.post(
        Uri.parse(
          'https://apidojo-yahoo-finance-v1.p.rapidapi.com/news/v2/list?region=US&snippetCount=28&s=AAPL',
        ),
        headers: {
          'X-RapidAPI-Host': 'apidojo-yahoo-finance-v1.p.rapidapi.com',
          'X-RapidAPI-Key': api,
        },
      );
      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final n.NewsModel responseData = n.newsModelFromJson(decodedResponse);
        _news = responseData.data.main.stream;
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

    _isLoadingNews = false;

    notifyListeners(); // Notify listeners that data fetching is complete
  }

  Future<void> fetchDetails(String url) async {
    _isLoadingDetails = true;
    _hasError = false;
    _errorMessage = '';

    try {
      // Prepare the request body as a JSON-encoded string
      final requestBody = json.encode({
        "language": "en",
        "site": url, // Use the URL parameter directly for the site
        "page":
            1, // Pass page as an integer since the API likely expects it as such
      });

      // Send the HTTP POST request with the JSON-encoded request body
      final response = await http.post(
        Uri.parse('https://newsnow.p.rapidapi.com/newsv2_top_news_site'),
        headers: {
          'X-RapidAPI-Host': 'newsnow.p.rapidapi.com',
          'X-RapidAPI-Key':
              'db6a0970ccmsh0f5067e3d31cf07p1cc59djsn96c676c0db70',
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final NewsDetailsModel responseData =
            newsDetailsModelFromJson(decodedResponse);
        _newsDetails = responseData.news;
      } else {
        _hasErrorDetails = true;
        _errorMessage =
            'Error ${response.statusCode}: ${json.decode(response.body)['error']}';
      }
    } catch (error) {
      _hasErrorDetails = true;
      _errorMessage =
          'Error: $error.\n\nThis API is free, so you cannot send multiple requests per second. Please wait and try again later.';
    }

    _isLoadingDetails = false;
    notifyListeners(); // Notify listeners that data fetching is complete
  }

  void emptyNewsDetails() {
    _newsDetails = [];
  }
}
