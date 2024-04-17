// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/provider/game_provider.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';

Padding topMenu(BuildContext context) {
  final gameProvider = Provider.of<GameProvider>(context);
  final currentMoney = gameProvider.money;
  return Padding(
    padding: const EdgeInsets.only(right: 10, top: 40),
    child: Row(
      children: <Widget>[
        back(context),
        const SizedBox(width: 10),
        level(gameProvider.level, gameProvider.currentXp,
            gameProvider.requiredXp),
        Expanded(child: Container()),
        money(currentMoney),
      ],
    ),
  );
}

Stack money(double currentMoney) {
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
          child: StrokeText(
            text: NumberFormat.compactSimpleCurrency(locale: 'en-US')
                .format(currentMoney),
            textStyle: const TextStyle(
              fontSize: 25,
              color: white,
            ),
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

Stack level(int currentLevel, double currentXp, double requiredXp) {
  int current = currentXp.round();
  int req = requiredXp.round();
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Positioned(
        top: 6,
        left: 20,
        child: Container(
          padding: const EdgeInsets.only(right: 10),
          alignment: Alignment.bottomRight,
          width: 100,
          height: 30,
          decoration: BoxDecoration(
            color: const Color(0xFFFCD800),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFF5861D),
              width: 4,
            ),
          ),
          child: StrokeText(
            text: '$current / $req',
            textStyle: const TextStyle(
              fontSize: 14,
              color: white,
            ),
            strokeColor: Colors.black,
            strokeWidth: 3,
          ),
        ),
      ),
      Container(
        width: 45,
        height: 45,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: AssetImage('assets/images/level.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: StrokeText(
            text: currentLevel.toString(),
            textStyle: const TextStyle(
              fontSize: 23,
              color: white,
            ),
            strokeColor: Colors.black,
            strokeWidth: 3,
          ),
        ),
      ),
    ],
  );
}

ElevatedButton back(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      // Add the action to be performed when the button is pressed
      Get.back();
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
