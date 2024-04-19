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
  String api = '40d7312818mshddd6877a4da2e17p190b63jsncfe0a925f21a';

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
          'https://apidojo-yahoo-finance-v1.p.rapidapi.com/news/v2/list?region=US&snippetCount=28&s=TSLA%2CAAPL%2C6033.KL%2C4707.KL%2CMETA%2CBABA%2CAMZN%2CCVX%2C5225.KL%2CMCD%2CPG%2CNFLX%2C1295.KL%2CBA%2C1023.KL%2CMETA%2CPFE%2C5168.KL%2C1155.KL%2CNVDA%2CWMT%2C7113.KL%2CV%2C6888.KL%2CMSFT%2CJNJ%2CHD%2CKO%2CJPM%2CGOOGL%2C%2CT%2CXOM%2CDIS',
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
              '1651139c27msh71996520d0ed192p1eb3b8jsn7c67cea4d8db',
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
