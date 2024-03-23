import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/dialog/buy_dialog.dart';
import 'package:investor_simulator/dialog/keystats_help_dialog.dart';
import 'package:investor_simulator/dialog/revenue_dialog.dart';
import 'package:investor_simulator/dialog/sell_dialog.dart';
import 'package:investor_simulator/provider/game_provider.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';

void openAnimatedDialog(BuildContext context, stockName, stockPrice, percentage,
    image, amount, index) {
  final portfolio = Provider.of<GameProvider>(context, listen: false);
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    pageBuilder: (context, animation1, animation2) {
      return Container();
    },
    transitionBuilder: (context, a1, a2, widget) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1).animate(a1),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.5, end: 1).animate(a1),
          child: Dialog(
            backgroundColor: white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(10), // Adjust padding as needed
              width: 400,
              height: 600,
              child: Scrollbar(
                  child: stockDetails(context, stockName, stockPrice,
                      percentage, image, portfolio, amount, index)),
            ),
          ),
        ),
      );
    },
  );
}

GestureDetector close(BuildContext context) {
  return GestureDetector(
    onTap: () {
      // Add the action to be performed when the button is pressed
      Navigator.pop(context);
    },
    child: Container(
      width: 48, // Adjust width to contain the icon
      height: 48, // Adjust height to contain the icon
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          Icons.close_rounded,
          color: Colors.black,
          size: 40, // Adjust the size of the icon as needed
        ),
      ),
    ),
  );
}

Center purchaseText() {
  return const Center(
    child: StrokeText(
      text: "PURCHASE",
      textStyle: TextStyle(fontSize: 30, color: yellow),
      strokeColor: darkPurple,
      strokeWidth: 7,
    ),
  );
}

Color getTextColor(String quantity) {
  return quantity == "0" ? Colors.red : Colors.green;
}

SingleChildScrollView stockDetails(BuildContext context, stockName, stockPrice,
    percentage, image, portfolio, amount, index) {
  String quantity = "0"; // Default value
  if (index >= 0 && index < portfolio.portfolio.length) {
    quantity = portfolio.portfolio[index].amount.toString();
  }

  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      children: [
        SizedBox(
          width: 350,
          height: 55,
          child: Stack(
            children: [
              Positioned(top: -2, right: 0, child: close(context)),
              purchaseText(),
            ],
          ),
        ),
        SizedBox(
          width: 300,
          height: 85,
          child: stockDetailsLogoName(context, image, stockName),
        ),
        const SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              const TextSpan(
                text: "You currently own ",
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  letterSpacing: 0,
                  fontSize: 14,
                  color: black,
                ),
              ),
              TextSpan(
                text: quantity,
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  letterSpacing: 0,
                  fontSize: 14,
                  color:
                      getTextColor(quantity), // Change the color of the number
                ),
              ),
              const TextSpan(
                text: " units of this stock.",
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  letterSpacing: 0,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(width: 15),
            StrokeText(
              text: "\$$stockPrice",
              textStyle: const TextStyle(
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
                fontSize: 20,
                color: green,
                overflow: TextOverflow.clip,
              ),
              strokeColor: Colors.transparent,
            ),
            Expanded(child: Container()),
            StrokeText(
              text: '($percentage)',
              textStyle: TextStyle(
                  fontSize: 16,
                  color: getColour(percentage),
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w700),
              strokeColor: Colors.transparent,
              strokeWidth: 5,
            ),
            const SizedBox(width: 15),
          ],
        ),
        const SizedBox(height: 5),
        stockChart(),
        const SizedBox(height: 10),
        Row(
          children: [
            sellStock(context, stockPrice, index),
            Expanded(child: Container()),
            buyStock(context, stockName, stockPrice, image, percentage),
          ],
        ),
        const Divider(
          thickness: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            children: [
              const Text('Key Stats',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 35,
                    color: purple,
                  )),
              Expanded(child: Container()),
              statsHelp(context),
            ],
          ),
        ),
        Row(
          children: [
            marketcap(),
            Expanded(child: Container()),
            dividend(),
          ],
        ),
        const SizedBox(height: 10),
        peRatio(),
        const SizedBox(height: 10),
        const Divider(
          thickness: 4,
        ),
        const SizedBox(height: 10),
        revenueReport(context, image, stockName),
        const SizedBox(height: 10),
      ],
    ),
  );
}

ElevatedButton statsHelp(BuildContext context) {
  final pageController = PageController(initialPage: 0);
  return ElevatedButton(
    onPressed: () {
      openKeyStatsHelpDialog(context, pageController);
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

ElevatedButton revenueReport(BuildContext context, image, stockName) {
  return ElevatedButton(
    onPressed: () {
      openRevenueDialog(context, image, stockName);
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      backgroundColor:
          Colors.transparent, // Set the background color to transparent
      elevation: 0, // Remove the elevation
    ),
    child: Container(
      alignment: Alignment.center,
      height: 50,
      width: 220,
      decoration: BoxDecoration(
        color: yellow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: orangeRed,
          width: 3,
        ),
      ),
      child: const StrokeText(
        text: 'VIEW REVENUE GROWTH',
        textStyle: TextStyle(
          fontSize: 18,
          color: white,
          letterSpacing: 1,
        ),
        strokeColor: black,
        strokeWidth: 4,
      ),
    ),
  );
}

Container stockChart() {
  return Container(
    width: 311,
    height: 150,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      image: DecorationImage(
        image: AssetImage('assets/images/stock.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

Container peRatio() {
  return Container(
    width: 200,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      color: Colors.transparent,
      border: Border.all(
        color: darkPurple,
        width: 4,
      ),
    ),
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Price-to-Earnings (P/E) Ratio',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: black,
            letterSpacing: 0,
            height: 0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 5),
        Text(
          '39.75',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: red,
            letterSpacing: 0,
            height: 0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Container dividend() {
  return Container(
    width: 150,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      color: Colors.transparent,
      border: Border.all(
        color: darkPurple,
        width: 4,
      ),
    ),
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Dividend Yield',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: black,
            letterSpacing: 0,
            height: 0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 5),
        Text(
          '0.00%',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: red,
            letterSpacing: 0,
            height: 0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Container marketcap() {
  return Container(
    width: 150,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      color: Colors.transparent,
      border: Border.all(
        color: darkPurple,
        width: 4,
      ),
    ),
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Market Capitalization',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: black,
            letterSpacing: 0,
            height: 0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 5),
        Text(
          '536.83 billion USD',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: green,
            letterSpacing: 0,
            height: 0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Stack stockDetailsLogoName(BuildContext context, image, stockName) {
  return Stack(
    children: [
      Positioned(
        top: 8,
        left: 2,
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
              color: darkPurple,
              width: 4,
            ),
          ),
          child: Center(
            child: Transform.scale(
              scale: 1.0, // Adjust the scale factor to make the image smaller
              child: Image.asset(
                image,
                width: 40, // Adjust the width of the image
                height: 40, // Adjust the height of the image
              ),
            ),
          ),
        ),
      ),
      Positioned(
        left: 80,
        top: 5,
        child: SizedBox(
          height: 80,
          width: 218,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              stockName,
              textAlign: TextAlign.left,
              maxLines: 3,
              style: const TextStyle(
                fontSize: 22,
                color: purple,
                overflow: TextOverflow.clip,
                height: 0,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

ElevatedButton sellStock(BuildContext context, stockPrice, index) {
  return ElevatedButton(
    onPressed: () {
      openSellDialog(context, stockPrice, index);
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      backgroundColor:
          Colors.transparent, // Set the background color to transparent
      elevation: 0, // Remove the elevation
    ),
    child: Container(
      alignment: Alignment.center,
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        color: red,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: darkRed,
          width: 4,
        ),
      ),
      child: const StrokeText(
        text: 'SELL',
        textStyle: TextStyle(fontSize: 18, color: white),
        strokeColor: black,
        strokeWidth: 4,
      ),
    ),
  );
}

ElevatedButton buyStock(
    BuildContext context, stockName, stockPrice, image, percentage) {
  return ElevatedButton(
    onPressed: () {
      openBuyDialog(context, stockName, stockPrice, image, percentage);
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    child: Container(
      alignment: Alignment.center,
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        color: lightGreen,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: green,
          width: 4,
        ),
      ),
      child: const StrokeText(
        text: 'BUY',
        textStyle: TextStyle(fontSize: 18, color: white),
        strokeColor: black,
        strokeWidth: 4,
      ),
    ),
  );
}

Color getColour(String percentage) {
  if (percentage.contains('-')) {
    return red;
  } else {
    return green;
  }
}
