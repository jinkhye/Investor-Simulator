import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/menu/topMenu.dart';
import 'package:stroke_text/stroke_text.dart';

class Assessment extends StatelessWidget {
  const Assessment({super.key});

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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Scrollbar(
                    thumbVisibility:
                        true, // Ensure the scrollbar is always visible
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          const Column(
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
                              Text(
                                '1. Concentration Risk:\n',
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
                                'Your portfolio may have a concentration of technology-related investments. While these companies have strong growth potential, a downturn in the technology sector could negatively impact your portfolio\'s performance.\n',
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
                                '2. Volatility:\n',
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
                                'Cryptocurrency investments like Bitcoin can be highly volatile and speculative. Consider the potential impact of such assets on the overall stability and risk profile of your portfolio.',
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
                                  image: AssetImage('assets/images/score.png'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
