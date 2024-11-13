import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/menu/topMenu.dart';
import 'package:investor_simulator/models/news_details_model.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class NewsAssessment extends StatelessWidget {
  final NewsDetails news;

  NewsAssessment({super.key, required this.news});
  String message1 = "Q1. Summarise the news in ONE paragraph. ";

  String message2 =
      "Q2. How will the news impacting the specific stocks ? (the stock is more likely to rise or drop?)";

  String message3 =
      "Q3. How is the market confidence? (how would the investors react to the news?) ";

  String message4 = "Q4. How is company performance ? ";

  String message5 =
      "Q5. what is your investment recommendations ?(buy , hold , sell)";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: fetchNewsText(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
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
          return buildNewsScreen(context, textList);
        }
      },
    );
  }

  Future<List<String>> fetchNewsText() async {
    String answer1 = await fetchText(news, message1);
    String answer2 = await fetchText(news, message2);

    String answer3 = await fetchText(news, message3);

    String answer4 = await fetchText(news, message4);
    String answer5 = await fetchText(news, message5);
    return [answer1, answer2, answer3, answer4, answer5];
  }

  Widget buildNewsScreen(BuildContext context, List<String> textList) {
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
                              textStyle: TextStyle(fontSize: 40, color: yellow),
                              strokeColor: darkPurple,
                              strokeWidth: 7,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Divider(thickness: 4),
                          Text(
                            news.title.toUpperCase(),
                            style: const TextStyle(
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                              fontSize: 25,
                              color: white,
                              overflow: TextOverflow.clip,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Container(
                              width: 330,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(news.topImage),
                                  fit: BoxFit.fill,
                                ),
                                border: const Border.fromBorderSide(
                                  BorderSide(
                                    color: black,
                                    width: 4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(thickness: 4),
                          const SizedBox(height: 20),
                          const Center(
                            child: StrokeText(
                              text: "SUMMARY",
                              textStyle: TextStyle(fontSize: 25, color: yellow),
                              strokeColor: darkPurple,
                              strokeWidth: 7,
                            ),
                          ),
                          const SizedBox(height: 10),
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
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 20),
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
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 25),
                          const StrokeText(
                            text: "1. MARKET CONFIDENCE",
                            textStyle: TextStyle(fontSize: 25, color: yellow),
                            strokeColor: darkPurple,
                            strokeWidth: 7,
                          ),
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 25),
                          const StrokeText(
                            text: "2. COMPANY PERFORMANCE",
                            textStyle: TextStyle(fontSize: 25, color: yellow),
                            strokeColor: darkPurple,
                            strokeWidth: 7,
                          ),
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 20),
                          const StrokeText(
                            text: "3. INVESTMENT RECOMMENDATIONS",
                            textStyle: TextStyle(fontSize: 25, color: yellow),
                            strokeColor: darkPurple,
                            strokeWidth: 7,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            textList[4],
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

  Future<String> fetchText(NewsDetails newss, String message) async {
    String api = dotenv.env['OPENAI_API_KEY'] ?? '';

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $api',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo-0125',
        'messages': [
          {
            'role': "user",
            'content':
                "You are now an AI stock's news analyzer . I strictly require you to analyze the news and give your opinion on the news. "
          },
          {
            'role': "user",
            'content':
                "These are the few main question that you have to answer :$message"
          },
          {'role': "user", 'content': "News: ${newss.text}"},
          {
            'role': "user",
            'content':
                "Answer each questions in sentence with brief and informative . I want only the answer in your response without labelling the question number. "
          },
        ],
        'max_tokens': 1700,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String content = data['choices'][0]['message']['content'];
      return content;
    } else {
      throw Exception('Failed to load text:${response.body}');
    }
  }
}
