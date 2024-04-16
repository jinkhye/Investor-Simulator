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
      future: fetchText(portfolioDetails),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<String> fetchedText = snapshot.data ?? [];

          return Scaffold(
            body: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [purple, darkPurple],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      topMenu(context),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            SizedBox(height: 10),
                            // Display fetched risks and improvements
                            for (String text in fetchedText)
                              Text(
                                text,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: text.startsWith("Risks") || text.startsWith("Improvements") ? 24 : 16,
                                  color: text.startsWith("Risks") || text.startsWith("Improvements") ? yellow : white,
                                  fontWeight: text.startsWith("Risks") || text.startsWith("Improvements") ? FontWeight.w900 : FontWeight.w600,
                                  wordSpacing: 0,
                                  letterSpacing: 0,
                                ),
                              ),
                            SizedBox(height: 20),
                            Divider(thickness: 4)
                          ],
                        ),
                      ),
                    ],
                  ),
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
        'Bearer [API_KEY]',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': "user",
            'content':
            "You are now a stocks' portfolio analyzer. Pay detail to every single sentence that I provide you. I strictly require you to analyze the portfolio and give your opinion on the following portfolio. Do not return your answer in bold form. These are the few main question that you have to answer : Q1. What is the potential risks that will occur to the portfolio?  Q2. What is the improvements that can be made to the portfolio.(How can i improve my portfolio).  "
          },
          {
            'role': "user",
            'content':
            "Answer each questions in sentence, briefly and informatively. Each response must be in between 30 to 50 words. At least 2 points for each risk and requirement. I want only the answer in your response without labelling the question number but label it with a title on what are u explaining.  Separate the title with your answers in sentences. Strictly follow the answer format that i provide you   "
          },
          {
            'role': "user",
            'content': "Portfolio: ${portfolioDetails.toString()}"
          },
          {
            'role': "system",
            'content':
                "Risks \n\n"
                "1) [Title of Risks] :  [Description]  \n\n"
                "2) [Title of Risks] : [Description]  \n\n"
                "Improvements \n\n"
                "1) [Title of Improvements] : [Description] \n\n"
                "2) [Title of Improvements] : [Description] \n\n"
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