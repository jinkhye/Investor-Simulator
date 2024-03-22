import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/dialog/stock_dialog.dart';

import 'package:investor_simulator/invest_page/stocks.dart';
import 'package:investor_simulator/menu/topMenu.dart';
import 'package:investor_simulator/models/portfolio_model.dart';
import 'package:investor_simulator/pages/assessment.dart';
import 'package:investor_simulator/provider/game_provider.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'mainmenu.dart';
import 'package:intl/intl.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    final imagePath = Provider.of<GameProvider>(context);
    List<PortfolioModel> portfolio = imagePath.portfolio;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
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
                child: stockMenu(context, portfolio),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double getTotal(List<PortfolioModel> portfolio) {
    double total = 0;
    for (int i = 0; i < portfolio.length; i++) {
      total += portfolio[i].total;
    }
    return total;
  }

  Column stockMenu(BuildContext context, List<PortfolioModel> portfolio) {
    return Column(
      children: <Widget>[
        Stack(
          children: [
            Center(child: stocksText()),
            Positioned(
              right: 10,
              top: 5,
              child: help(context),
            ),
          ],
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: '\$ ',
                style: TextStyle(
                  fontFamily: 'MightySouly',
                  fontSize: 40,
                  color: lightGreen,
                ),
              ),
              TextSpan(
                text: getTotal(portfolio).toStringAsFixed(2),
                style: const TextStyle(
                  fontFamily: 'Helvetica',
                  color: white,
                  fontWeight: FontWeight.w800,
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: StrokeText(
              text: "YOUR ASSETS",
              textStyle: TextStyle(fontSize: 30, color: yellow),
              strokeColor: darkPurple,
              strokeWidth: 7,
            ),
          ),
        ),
        const Divider(
          thickness: 4,
          indent: 15,
          endIndent: 15,
        ),
        Builder(
          builder: (context) {
            if (portfolio.isEmpty) {
              return const Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'YOUR PORTFOLIO IS EMPTY!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Expanded(
                  child: Scrollbar(child: _stocksSection(portfolio)));
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0, top: 10),
          child: aiAssessment(context, portfolio),
        )
      ],
    );
  }

  ElevatedButton aiAssessment(
      BuildContext context, List<PortfolioModel> portfolio) {
    return ElevatedButton(
      onPressed: () {
        Get.to(() => const Assessment(),
            transition: Transition.circularReveal,
            duration: const Duration(milliseconds: 800));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor:
            Colors.transparent, // Set the background color to transparent
        elevation: 0, // Remove the elevation
      ),
      child: Container(
        alignment: Alignment.center,
        height: 70,
        width: 280,
        decoration: BoxDecoration(
          color: yellow,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: orangeRed,
            width: 3,
          ),
        ),
        child: const StrokeText(
          text: 'BEGIN AI ASSESSMENT',
          textStyle: TextStyle(
            fontSize: 24,
            color: white,
            letterSpacing: 1,
          ),
          strokeColor: black,
          strokeWidth: 4,
        ),
      ),
    );
  }

  Color getColour(String percentage) {
    if (percentage.contains('-')) {
      return red;
    } else if (percentage.contains('+')) {
      return lightGreen;
    } else {
      return Colors.grey;
    }
  }

  Column _stocksSection(List<PortfolioModel> portfolio) {
    // Get the current date
    DateTime now = DateTime.now();

    // Format the date using a DateFormat object
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: portfolio.length,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(left: 20, right: 20),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topRight,
                      height: 120,
                      width: 330,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Positioned(
                        bottom: 5,
                        right: 35,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '(0.00%)',
                                style: TextStyle(
                                  fontFamily: 'MightySouly',
                                  fontSize: 18,
                                  color: getColour(
                                    '0.00',
                                  ),
                                  // Set text color to black
                                ),
                              ),
                              TextSpan(
                                text:
                                    '  \$${portfolio[index].price}', // Add space to separate the stroke
                                style: const TextStyle(
                                  fontFamily: 'Helvetica',
                                  color: green, // Set stroke color to white
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                      top: 5,
                      left: 105,
                      child: SizedBox(
                        width: 210,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              portfolio[index].name,
                              style: const TextStyle(
                                letterSpacing: 0.5,
                                fontSize: 20,
                                color: darkPurple,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Total: ',
                                    style: TextStyle(
                                      fontFamily: 'MightySouly',

                                      fontSize: 18,
                                      color: purple, // Set text color to black
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '\$${portfolio[index].total}', // Add space to separate the stroke
                                    style: const TextStyle(
                                      fontFamily: 'Helvetica',
                                      color: green, // Set stroke color to white
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Quantity: ${portfolio[index].amount}',
                              style: const TextStyle(
                                color: purple,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 30,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: white,
                          border: Border.all(
                            color: darkPurple,
                            width: 4,
                          ),
                        ),
                        child: Center(
                          child: Transform.scale(
                            scale:
                                0.75, // Adjust the scale factor to make the image smaller
                            child: Image.asset(
                              portfolio[index].iconPath,
                              width: 40, // Adjust the width of the image
                              height: 40, // Adjust the height of the image
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 30,
                      child: Text(
                        formattedDate,
                        style: const TextStyle(
                          fontFamily: 'Helvetica',
                          color: darkPurple,
                          fontSize: 14,
                          letterSpacing: 0,
                          wordSpacing: 0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Positioned(child: accept(context, index, portfolio)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  ElevatedButton accept(BuildContext context, index, portfolio) {
    return ElevatedButton(
      onPressed: () {
        openAnimatedDialog(
            context,
            portfolio[index].name,
            portfolio[index].price,
            portfolio[index].percentage,
            portfolio[index].iconPath,
            portfolio[index].amount,
            index);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor:
            Colors.transparent, // Set the background color to transparent
        elevation: 0, // Remove the elevation
      ),
      child: Container(
        height: 115,
        width: 330,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
      ),
    );
  }

  StrokeText stocksText() {
    return const StrokeText(
      text: "MY PORTFOLIO",
      textStyle: TextStyle(fontSize: 40, color: yellow),
      strokeColor: darkPurple,
      strokeWidth: 7,
    );
  }

  Stack money() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          child: Container(
            padding: const EdgeInsets.only(right: 10),
            alignment: Alignment.bottomRight,
            width: 150,
            height: 45,
            decoration: BoxDecoration(
              color: lightGreen,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: green,
                width: 4,
              ),
            ),
            child: const StrokeText(
              text: "10.000k",
              textStyle: TextStyle(fontSize: 25, color: Colors.white),
              strokeColor: Colors.black,
              strokeWidth: 3,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: -20,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage('assets/images/money.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ],
    );
  }

  ElevatedButton back(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add the action to be performed when the button is pressed
        Get.to(() => const MainMenu());
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: const CircleBorder(
          side: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [purple, darkPurple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
