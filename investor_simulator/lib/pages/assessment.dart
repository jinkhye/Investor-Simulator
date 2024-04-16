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
      future: fetchText(portfolioDetails), // Call the fetchText method
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while waiting for data
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handle any errors that occur during the fetchText process
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // Once data is loaded successfully, display the fetched text
          List<String> fetchedText = snapshot.data ?? [];
          bool reachedImprovements = false;

          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [purple, darkPurple], // Adjust colors as needed
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
                        thumbVisibility:
                            true, // Ensure the scrollbar is always visible
                        child: SingleChildScrollView(
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  StrokeText(
                                    text: "YOUR PERSONALIZED",
                                    textStyle:
                                        TextStyle(fontSize: 40, color: yellow),
                                    strokeColor: darkPurple,
                                    strokeWidth: 7,
                                  ),
                                  SizedBox(height: 10),
                                  StrokeText(
                                    text: "ASSESSMENT",
                                    textStyle:
                                        TextStyle(fontSize: 40, color: yellow),
                                    strokeColor: darkPurple,
                                    strokeWidth: 7,
                                  ),
                                  SizedBox(height: 20),
                                  Divider(
                                    thickness: 4,
                                  ),
                                  SizedBox(height: 20),
                                  StrokeText(
                                    text: "ISSUES",
                                    textStyle:
                                        TextStyle(fontSize: 30, color: white),
                                    strokeColor: darkPurple,
                                    strokeWidth: 7,
                                  ),
                                  SizedBox(height: 10),
                                  // Display fetched risks
                                  for (int i = 0;
                                      i < fetchedText.length &&
                                          fetchedText[i] != "Improvements: ";
                                      i++)
                                    Text(
                                      fetchedText[i],
                                      style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        fontSize: i % 2 == 0 ? 20 : 16,
                                        color: i % 2 == 0 ? yellow : white,
                                        fontWeight: i % 2 == 0
                                            ? FontWeight.w800
                                            : FontWeight.w600,
                                        wordSpacing: 0,
                                        letterSpacing: 0,
                                      ),
                                    ),

                                  SizedBox(height: 20),
                                  Divider(
                                    thickness: 4,
                                  ),
                                  SizedBox(height: 20),
                                  StrokeText(
                                    text: "IMPROVEMENTS",
                                    textStyle:
                                        TextStyle(fontSize: 30, color: white),
                                    strokeColor: darkPurple,
                                    strokeWidth: 7,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '1. Risk Management:\n',
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
                                    'Given the concentration risk in technology-related stocks (Tesla, Microsoft) and cryptocurrency (Bitcoin) \n\nYou may consider rebalancing your portfolio to reduce overexposure to these sectors. This could involve trimming some holdings in Tesla, Microsoft, and Bitcoin and reallocating funds to other sectors or asset classes to achieve a more balanced portfolio.',
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontSize: 16,
                                      color: white,
                                      fontWeight: FontWeight.w600,
                                      wordSpacing: 0,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                ],
                              ),
                              Positioned(
                                right: 20,
                                top: 95,
                                child: Container(
                                  height: 140,
                                  width: 130,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/score.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
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
      },
    );
  }

  Future<List<String>> fetchText(
      List<Map<String, dynamic>> portfolioDetails) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization':
            'Bearer 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',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo-0125',
        'messages': [
          {
            'role': "user",
            'content':
                "You are now an AI stocks' portfolio analyzer . I strictly require you to analyze the portfolio and give your opinion on the following portfolio. These are the few main question that you have to answer : Q1. What is the potential risks that will occur to the portfolio?  Q2. What is the improvements that can be made to the portfolio.(How can i improve my portfolio).  "
          },
          {
            'role': "user",
            'content':
                "Answer each questions in sentence with brief and informative. I want only the answer in your response without labelling the question number but label it with a title on what are u explaining.  Separate the title with your answers in sentences. Strictly follow the answer format:   Risks \n 1) Title of Risks: \n Description  2) Title of Risks : Description  Improvements 1) Title of Improvements: Description 2) Title of Improvements: Description "
          },
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
      print(content);

      // Initialize arrays to store risks and improvements
      List<String> allAnswers = [];
      for (String message in messages) {
        List<String> parts =
            message.split('\n'); // Split the message into parts
        allAnswers.addAll(parts); // Add the parts to the array
      }

      return allAnswers;
    } else {
      throw Exception('Failed to load text:${response.body}');
    }
  }
}
