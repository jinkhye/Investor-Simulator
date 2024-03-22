import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/dialog/stock_dialog.dart';
import 'package:investor_simulator/dialog/stock_help_dialog.dart';
import 'package:investor_simulator/models/etf_model.dart';
import 'package:stroke_text/stroke_text.dart';

List<ETFModel> etf = [];

void _getInitialInfo() {
  etf = ETFModel.getETF();
}

Column etfMenu(BuildContext context, imagePath) {
  _getInitialInfo();
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
      const SizedBox(height: 5),
      Container(
        width: 360,
        height: 10,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/risklevel_etf.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Expanded(
        child: _stocksSection(imagePath),
      ),
    ],
  );
}

Column _stocksSection(imagePath) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10),
      Expanded(
        child: ListView.builder(
          itemCount: etf.length,
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
                    height: 100,
                    width: 330,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    right: 35,
                    child: StrokeText(
                      text: etf[index].percentage,
                      textStyle: TextStyle(
                          fontSize: 16,
                          color: etf[index].colour,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w700),
                      strokeColor: white,
                      strokeWidth: 5,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 35,
                    child: StrokeText(
                      text: "\$${etf[index].price}",
                      textStyle: const TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                        fontSize: 18,
                        color: green,
                        overflow: TextOverflow.clip,
                      ),
                      strokeColor: white,
                      strokeWidth: 5,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 125,
                    child: SizedBox(
                      width: 145,
                      child: StrokeText(
                        text: etf[index].name,
                        textStyle: const TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 18,
                          color: purple,
                          overflow: TextOverflow.clip,
                        ),
                        strokeColor: white,
                        strokeWidth: 4,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 30,
                    child: Container(
                      height: 85,
                      width: 85,
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
                              1.0, // Adjust the scale factor to make the image smaller
                          child: Image.asset(
                            etf[index].iconPath,
                            width: 40, // Adjust the width of the image
                            height: 40, // Adjust the height of the image
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(child: accept(context, index, imagePath)),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}

ElevatedButton accept(BuildContext context, index, imagePath) {
  return ElevatedButton(
    onPressed: () {
      openAnimatedDialog(context, etf[index].name, etf[index].price,
          etf[index].percentage, etf[index].iconPath, 0, index);
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
      height: 100,
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
    text: "ETF MARKET",
    textStyle: TextStyle(fontSize: 40, color: yellow),
    strokeColor: darkPurple,
    strokeWidth: 7,
  );
}

ElevatedButton help(BuildContext context) {
  final pageController = PageController(initialPage: 1);
  return ElevatedButton(
    onPressed: () {
      openStockHelpDialog(context, pageController);
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: const CircleBorder(
        side: BorderSide(color: darkPurple, width: 4),
      ),
    ),
    child: Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: purple,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          Icons.help_outline,
          color: Colors.white,
          size: 40,
        ),
      ),
    ),
  );
}
