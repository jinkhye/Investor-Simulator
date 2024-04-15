import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/menu/topMenu.dart';
import 'package:investor_simulator/models/news_details_model.dart';
import 'package:investor_simulator/models/news_model.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsAssessment extends StatelessWidget {
  final NewsDetails news;

  const NewsAssessment({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: fetchText(news),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          List<String> textList = snapshot.data ?? [];
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [purple, darkPurple],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    topMenu(context),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                const Align(
                                  alignment: Alignment.center,
                                  child: StrokeText(
                                    text: "NEWS ASSESSMENT",
                                    textStyle:
                                        TextStyle(fontSize: 40, color: yellow),
                                    strokeColor: darkPurple,
                                    strokeWidth: 7,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Divider(
                                  thickness: 4,
                                ),
                                Text(
                                  news.title,
                                  style: const TextStyle(
                                    letterSpacing: 0.8,
                                    fontSize: 30,
                                    color: white,
                                    overflow: TextOverflow.clip,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                Center(
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                        image: NetworkImage(news.topImage),
                                        fit: BoxFit.cover,
                                      ),
                                      border: const Border.fromBorderSide(
                                          BorderSide(
                                        color: black,
                                        width: 4,
                                      )),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Divider(
                                  thickness: 4,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  textList[0],
                                  style: const TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 16,
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                    wordSpacing: 0,
                                    letterSpacing: 0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  '1. Market Confidence:\n',
                                  style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 20,
                                    color: yellow,
                                    fontWeight: FontWeight.w800,
                                    wordSpacing: 0,
                                    letterSpacing: 0,
                                  ),
                                ),
                                Text(
                                  textList[1],
                                  style: const TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 16,
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                    wordSpacing: 0,
                                    letterSpacing: 0,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  '2. Company performance:\n',
                                  style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 20,
                                    color: yellow,
                                    fontWeight: FontWeight.w800,
                                    wordSpacing: 0,
                                    letterSpacing: 0,
                                  ),
                                ),
                                Text(
                                  textList[2],
                                  style: const TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 16,
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                    wordSpacing: 0,
                                    letterSpacing: 0,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  '3. Investment Recommendation:\n',
                                  style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 20,
                                    color: yellow,
                                    fontWeight: FontWeight.w800,
                                    wordSpacing: 0,
                                    letterSpacing: 0,
                                  ),
                                ),
                                Text(
                                  textList[3],
                                  style: const TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 16,
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                    wordSpacing: 0,
                                    letterSpacing: 0,
                                  ),
                                ),
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Future<List<String>> fetchText(NewsDetails newss) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),

      headers: {
        'Authorization': 'Bearer hellothisistheapikeyyoucannotusehaha',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-4',
        'messages': [
          {
            'role': "user",
            'content':
            "You are now an AI stock's news analyzer . I strictly require you to analyze the news and give your opinion on the news. "
          },
          {
            'role': "user",
            'content':
            "These are the few main question that you have to answer : Q1. How will the news impacting the specific stocks ? (the stock is more likely to rise or drop?) Q2. How is the market confidence? (how would the investors react to the news?) Q3. How is company performance ? Q4. what is your investment recommendations, you must choose an options between buy , hold ,and sell and answer it in your response"
          },
          {
            'role': "user",
            'content': "News: ${newss.title}"
          },
          {
            'role': "user",
            'content':
            "Answer each questions in sentence with brief and informative. I want only the answer in your response without labelling the question number. "
          },
        ],
        'max_tokens': 2000,
      }),
    );


    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String content = data['choices'][0]['message']['content'];
      List<String> messages = content.split(
          '. '); // Split the response into an array based on newline characters
      return messages;
    } else {
      throw Exception('Failed to load text:${response.body}');
    }
  }
}
