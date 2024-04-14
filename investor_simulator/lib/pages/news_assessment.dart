import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/menu/topMenu.dart';
import 'package:investor_simulator/models/news_model.dart';
import 'package:stroke_text/stroke_text.dart';

class NewsAssessment extends StatelessWidget {
  const NewsAssessment({super.key, required this.news, required this.index});

  final List<NewsModel> news;
  final int index;

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              topMenu(context),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Scrollbar(
                    thumbVisibility:
                        true, // Ensure the scrollbar is always visible
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: StrokeText(
                              text: "NEWS ASSESSMENT",
                              textStyle: TextStyle(fontSize: 40, color: yellow),
                              strokeColor: darkPurple,
                              strokeWidth: 7,
                            ),
                          ),
                          SizedBox(height: 20),
                          Divider(
                            thickness: 4,
                          ),
                          Text(
                            'news[index].name',
                            style: TextStyle(
                              letterSpacing: 0.8,
                              fontSize: 30,
                              color: white,
                              overflow: TextOverflow.clip,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          // Center(
                          //   child: Container(
                          //     width: 150,
                          //     height: 150,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(16),
                          //       image: DecorationImage(
                          //         image: AssetImage(news[index].iconPath),
                          //         fit: BoxFit.fill,
                          //       ),
                          //       border: const Border.fromBorderSide(
                          //         BorderSide(
                          //           color: white,
                          //           width: 4,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 4,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Based on Tesla\'s advancement in battery technology, there is a strong likelihood that Tesla\'s stock price will rise.',
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontSize: 16,
                              color: white,
                              fontWeight: FontWeight.w600,
                              wordSpacing: 0,
                              letterSpacing: 0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Text(
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
                            'Investors are likely to react positively to the news, as it demonstrates Tesla\'s continued leadership in innovation within the electric vehicle industry.\n',
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontSize: 16,
                              color: white,
                              fontWeight: FontWeight.w600,
                              wordSpacing: 0,
                              letterSpacing: 0,
                            ),
                          ),
                          Text(
                            '2. Competitive Advantage:\n',
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
                            'Tesla\'s next-generation battery cell with superior energy density and longevity gives the company a competitive edge over rivals. This innovation by Tesla is likely to attract investors who anticipate long-term growth.',
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontSize: 16,
                              color: white,
                              fontWeight: FontWeight.w600,
                              wordSpacing: 0,
                              letterSpacing: 0,
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(height: 40),
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
}
