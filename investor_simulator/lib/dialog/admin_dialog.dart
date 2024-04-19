import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/pages/home.dart';
import 'package:investor_simulator/provider/game_provider.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';

void openAdminDialog(BuildContext context) {
  // ignore: unused_local_variable
  final provider = Provider.of<GameProvider>(context, listen: false);
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
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: 150,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: white, width: 6),
                color: Colors.amber,
              ),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  helpPage3(context),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Get.to(const HomePage());
                    },
                    child: const Icon(
                      Icons.home_rounded,
                      color: white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              )),
            ),
          ),
        ),
      );
    },
  );
}

Widget helpPage3(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Stack(
          children: [
            helpText('ADMIN'),
            Positioned(top: -2, right: 0, child: close(context)),
          ],
        ),
        const SizedBox(height: 5),
        const StrokeText(
          text: 'LEVEL',
          textStyle: TextStyle(fontSize: 20, color: white, letterSpacing: 2),
          strokeColor: darkPurple,
          strokeWidth: 4,
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            levelButton(context, '+5'),
            levelButton(context, '+10'),
            levelButton(context, 'MAX'),
          ],
        ),
        const SizedBox(height: 5),
        const StrokeText(
          text: 'MONEY',
          textStyle: TextStyle(fontSize: 20, color: white, letterSpacing: 2),
          strokeColor: darkPurple,
          strokeWidth: 4,
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            moneyButton(context, 100),
            moneyButton(context, 1000),
            moneyButton(context, 100000),
          ],
        ),
      ],
    ),
  );
}

Widget moneyButton(BuildContext context, int text) {
  final provider = Provider.of<GameProvider>(context, listen: false);
  return GestureDetector(
    onTap: () {
      provider.adminMoney(text.toDouble());
    },
    child: Container(
      height: 40,
      width: 80,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: darkPurple,
          width: 2,
        ),
      ),
      child: Center(
        child: StrokeText(
          text:
              '+${NumberFormat.compactSimpleCurrency(locale: 'en-US').format(text)}',
          textStyle: const TextStyle(
              letterSpacing: 1.5,
              fontSize: 20,
              color: lightGreen,
              fontWeight: FontWeight.w100),
          strokeWidth: 4,
          strokeColor: black,
        ),
      ),
    ),
  );
}

Widget levelButton(BuildContext context, String text) {
  final provider = Provider.of<GameProvider>(context, listen: false);
  int level = 0;
  switch (text) {
    case '+5':
      level = 5;
      break;
    case '+10':
      level = 10;
      break;
    case 'MAX':
      level = 100;
      break;
  }
  return GestureDetector(
    onTap: () {
      provider.adminLevel(level);
    },
    child: Container(
      height: 40,
      width: 60,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: darkPurple,
          width: 2,
        ),
      ),
      child: Center(
        child: StrokeText(
          text: text,
          textStyle: const TextStyle(
              letterSpacing: 1.5,
              fontSize: 20,
              color: yellow,
              fontWeight: FontWeight.w100),
          strokeWidth: 4,
          strokeColor: black,
        ),
      ),
    ),
  );
}

Widget helpText(String text) {
  return Column(
    children: [
      Center(
        child: StrokeText(
          text: text,
          textStyle:
              const TextStyle(fontSize: 25, color: white, letterSpacing: 2),
          strokeColor: darkPurple,
          strokeWidth: 5,
        ),
      ),
      const Text(
        '(For Demo Only)',
        style: TextStyle(
            fontSize: 14,
            color: darkPurple,
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.w700),
      ),
    ],
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
