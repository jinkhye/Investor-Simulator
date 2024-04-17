import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/menu/topMenu.dart';
import 'package:investor_simulator/provider/portfolio_provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Assessment extends StatelessWidget {
  final PortfolioProvider portfolioProvider;

  const Assessment({super.key, required this.portfolioProvider});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> portfolioDetails = [];
    String question1 =
        "Q1. What is the potential risks that will occur to the portfolio? ";
    String question2 =
        "Q2. What is the improvements that can be made to the portfolio.(How can i improve my portfolio) (Do not mention the problems) ";
    portfolioProvider.portfolio.forEach((symbol, investment) {
      Map<String, dynamic> details = {
        'symbol': symbol,
        'purchasePrice': investment['purchasePrice'],
        'currentValue': investment['totalValue'],
        'quantity': investment['quantity'],
      };

      portfolioDetails.add(details);
    });

    return FutureBuilder<List<String>>(
      future: fetchText(portfolioDetails, question1),
      builder: (context, snapshot1) {
        if (snapshot1.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot1.hasError) {
          return Center(child: Text('Error: ${snapshot1.error}'));
        } else {
          // Process fetched data here
          List<String> fetchedText1 = snapshot1.data ?? [];
          return FutureBuilder<List<String>>(
            future: fetchText(portfolioDetails, question2),
            builder: (context, snapshot2) {
              if (snapshot2.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot2.hasError) {
                return Center(child: Text('Error: ${snapshot2.error}'));
              } else {
                // Process fetched data here
                List<String> fetchedText2 = snapshot2.data ?? [];
                return _buildAssessmentScreen(
                    context, fetchedText1, fetchedText2);
              }
            },
          );
        }
      },
    );
  }

  Widget _buildAssessmentScreen(BuildContext context, List<String> fetchedText1,
      List<String> fetchedText2) {
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
          child: ListView(
            children: [
              topMenu(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        StrokeText(
                          text: "YOUR PERSONALIZED",
                          textStyle: TextStyle(fontSize: 40, color: yellow),
                          strokeColor: darkPurple,
                          strokeWidth: 7,
                        ),
                        SizedBox(height: 10),
                        StrokeText(
                          text: "ASSESSMENT",
                          textStyle: TextStyle(fontSize: 40, color: yellow),
                          strokeColor: darkPurple,
                          strokeWidth: 7,
                        ),
                        SizedBox(height: 20),
                        Divider(thickness: 4),
                        SizedBox(height: 20),
                        StrokeText(
                          text: "ISSUES",
                          textStyle: TextStyle(fontSize: 30, color: white),
                          strokeColor: darkPurple,
                          strokeWidth: 7,
                        ),
                        SizedBox(height: 10),
                        // Display fetched risks from question 1
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: fetchedText1.length,
                          itemBuilder: (context, index) {
                            return Text(
                              fetchedText1[index],
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                                fontSize: 20,
                                color: white,
                                fontWeight: index % 2 == 0
                                    ? FontWeight.w800
                                    : FontWeight.w600,
                                wordSpacing: 0,
                                letterSpacing: 0,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        Divider(thickness: 4),
                        SizedBox(height: 20),
                        StrokeText(
                          text: "IMPROVEMENTS",
                          textStyle: TextStyle(fontSize: 30, color: white),
                          strokeColor: darkPurple,
                          strokeWidth: 7,
                        ),
                        SizedBox(height: 10),
                        // Display fetched improvements from question 2
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: fetchedText2.length,
                          itemBuilder: (context, index) {
                            return Text(
                              fetchedText2[index],
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                                fontSize: 20,
                                color: white,
                                fontWeight: index % 2 == 0
                                    ? FontWeight.w800
                                    : FontWeight.w600,
                                wordSpacing: 0,
                                letterSpacing: 0,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 40),
                      ],
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

  Future<List<String>> fetchText(
      List<Map<String, dynamic>> portfolioDetails, String message) async {
    String format = "risk";

    if (message.contains('Q2')) {
      format = "improvements";
    }

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization':
            'Bearer sk-proj-IuZJM0Qxv3tzoyQNx15UT3BlbkFJ289u6N8DjSpJsBUKTQtr',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo-0125',
        'messages': [
          {
            'role': "user",
            'content':
                "You are now a stocks' portfolio analyzer. Pay detail to every single sentence that I provide you. I strictly require you to analyze the portfolio and give your opinion on the following portfolio. Do not return your answer in bold form. This is the main question that you have to answer : ${message} "
          },
          {
            'role': "user",
            'content':
                "Answer each questions in sentence, briefly and informatively. Each response must be in between 30 to 50 words and only. At least 2 points for ${format}. 1 point should include only 1 paragraph description. I want only the answer in your response without labelling the question number but label it with a title on what are u explaining.  Separate the title with your answers in sentences. Strictly follow the answer format that i provide you."
          },
          {
            'role': "user",
            'content': "Portfolio: ${portfolioDetails.toString()}"
          },
          {
            'role': "user",
            'content':
                "DO NOT INCLUDE ANYTHING HERE 1) [ Title of ${format}]:   [YOUR ANSWER HERE]   \n\n 2) [ (Title of ${format}]: [Description] )\n\n "
          },
          {'role': "user", 'content': ""},
        ],
        'max_tokens': 1700,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String content = data['choices'][0]['message']['content'];
      // Split the content into individual sentences
      List<String> messages = content.split('. ');
      // Initialize list to store split parts
      List<String> allAnswers = [];
      for (String message in messages) {
        // Split the message into parts
        List<String> parts = message.split(':');
        for (int i = 0; i < parts.length; i++) {
          if (i == 0) {
            // Add the first part with index prefix
            allAnswers.add('${parts[i].trim()} :');
          } else {
            // Add the remaining parts without any modification
            allAnswers.add(parts[i].trim());
          }
        }
      }
      return allAnswers;
    } else {
      throw Exception('Failed to load text:${response.body}');
    }
  }
}
