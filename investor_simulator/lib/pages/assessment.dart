import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/menu/topMenu.dart';
import 'package:investor_simulator/provider/portfolio_provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Assessment extends StatelessWidget {
  final PortfolioProvider portfolioProvider;

  Assessment({super.key, required this.portfolioProvider});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> portfolioDetails = [];
    String question1 =
        "Q1. What is the potential risks that will occur to the portfolio? ";
    String question2 =
        "Q2. What is the improvements that can be made to the portfolio.(How can i improve my portfolio) (Do not mention the problems) ";
    String question3 =
        "Q3. How much the score u think the portfolio valued(1-100)? ( give me the score only (ONLY DIGITS), do not include any explanation or description ) ";
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
                return FutureBuilder<List<String>>(
                  future: fetchText(portfolioDetails,
                      question3), // Add your third question here
                  builder: (context, snapshot3) {
                    if (snapshot3.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot3.hasError) {
                      return Center(child: Text('Error: ${snapshot3.error}'));
                    } else {
                      // Process fetched data here
                      List<String> fetchedText3 = snapshot3.data ?? [];
                      return _buildAssessmentScreen(
                          context, fetchedText1, fetchedText2, fetchedText3);
                    }
                  },
                );
              }
            },
          );
        }
      },
    );
  }

  Widget _buildAssessmentScreen(BuildContext context, List<String> fetchedText1,
      List<String> fetchedText2, List<String> fetchedText3) {
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
          child: Stack(
            children: [
              ListView(
                children: [
                  topMenu(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                        Row(
                          children: [
                            StrokeText(
                              text: "SCORE : ",
                              textStyle: TextStyle(fontSize: 40, color: white),
                              strokeColor: darkPurple,
                              strokeWidth: 7,
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: 200, // Adjust the width as needed
                              child: StrokeText(
                                text: fetchedText3[0],
                                textStyle: TextStyle(
                                  fontSize: 40,
                                  color: white,
                                  fontWeight: FontWeight.w800,
                                  wordSpacing: 0,
                                  letterSpacing: 0,
                                ),
                                strokeColor:
                                    darkPurple, // Match the stroke color
                                strokeWidth: 7,
                              ),
                            ),
                          ],
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
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fetchedText1[index],
                                  style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 20,
                                    color: fetchedText1[index].contains(':')
                                        ? yellow
                                        : white,
                                    fontWeight: FontWeight.w800,
                                    wordSpacing: 0,
                                    letterSpacing: 0,
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
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
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fetchedText2[index],
                                  style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 20,
                                    color: fetchedText2[index].contains(')') &
                                            fetchedText2[index].contains(':')
                                        ? yellow
                                        : white,
                                    fontWeight: FontWeight.w800,
                                    wordSpacing: 0,
                                    letterSpacing: 0,
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<String>> fetchText(
      List<Map<String, dynamic>> portfolioDetails, String message) async {
    String type = "Strictly do not follow the format ";
    String format =
        "DO NOT INCLUDE ANYTHING HERE  1) [Title of ${type}] : [YOUR ANSWER HERE]   \n\n 2) [(Title of ${type}] : [YOUR ANSWER HERE] )\n\n";
    String description =
        "Answer each questions in sentence, briefly and informatively. Each response must be in between 30 to 50 words and only. At least 2 points for ${format}. 1 point should include only 1 paragraph description. I want only the answer in your response without labelling the question number but label it with a title on what are u explaining.  Separate the title with your answers in sentences. Strictly follow the answer format that i provide you. ";

    if (message.contains('Q2.')) {
      type = "improvements";
    }
    if (message.contains('Q1.')) {
      type = "risk";
    } else if (message.contains('Q3.')) {
      description = " ";
      format = " ";
    }

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization':
            'Bearer sk-proj-qf7W4UCemsPZlSlERSmPT3BlbkFJ029EHqgofI4BRY5HAgyI',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo-0125',
        'messages': [
          {
            'role': "user",
            'content':
                "You are now a stocks' portfolio analyzer. Pay detail to every single sentence that I provide you. I strictly require you to analyze the portfolio and give your opinion on the following portfolio. Do not return your answer in bold form. This is the main question that you have to answer : ${message}   "
          },
          {'role': "user", 'content': "${description}"},
          {'role': "user", 'content': "${format}}"},
          {
            'role': "user",
            'content': "Portfolio: ${portfolioDetails.toString()}"
          },
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
        // Check if the message ends with a colon
        if (message.endsWith(':')) {
          // If it does, add it directly to allAnswers
          allAnswers.add(message.trim());
        } else {
          // If not, split the message into parts
          List<String> parts = message.split(':');
          if (parts.length > 1) {
            // If the message contains a colon, add the first part with index prefix
            allAnswers.add('${parts[0].trim()} :');
            // Add the remaining parts without any modification
            allAnswers.addAll(parts.sublist(1).map((part) => part.trim()));
          } else {
            // If the message doesn't contain a colon, add it directly to allAnswers
            allAnswers.add(message.trim());
          }
        }
      }
      return allAnswers;
    } else {
      throw Exception('Failed to load text:${response.body}');
    }
  }
}
