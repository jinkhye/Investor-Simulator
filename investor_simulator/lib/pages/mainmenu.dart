import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/menu/topMenu.dart';
import 'package:investor_simulator/pages/clothes.dart';
import 'package:investor_simulator/pages/home.dart';
import 'package:investor_simulator/pages/accomodation.dart';
import 'package:investor_simulator/pages/invest.dart';
import 'package:investor_simulator/pages/news.dart';
import 'package:investor_simulator/pages/portfolio.dart';
import 'package:investor_simulator/provider/game_provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  DateTime _dateTime = DateTime.now();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Ensure timer is cancelled when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<GameProvider>(context);
    final imagePath = imageProvider.imagePath;
    final maxPath = imageProvider.maxPath;
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
          child: gameMenu(context, imagePath, maxPath),
        ),
      ),
    );
  }

  Column gameMenu(BuildContext context, imagePath, maxPath) {
    return Column(
      children: <Widget>[
        topMenu(context),
        const SizedBox(
          height: 10,
        ),
        middleMenu(context),

        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
          child: backgroundMax(context, imagePath, maxPath),
        ),
        Expanded(child: Container()), // Empty Expanded widget for empty space
        bottomMenu(context),
        Expanded(child: Container()), // Empty Expanded widget for empty space
      ],
    );
  }

  Padding bottomMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 15, right: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            invest(context),
            const SizedBox(width: 20),
            portfolio(context),
            const SizedBox(width: 20),
            news(context),
            const SizedBox(width: 20),
            accomodation(context),
            const SizedBox(width: 20),
            clothes(context),
          ],
        ),
      ),
    );
  }

  Widget news(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Add the action to be performed when the button is pressed
            Get.to(() => const News(),
                transition: Transition.circularReveal,
                duration: const Duration(milliseconds: 800));
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor:
                Colors.transparent, // Set the background color to transparent
            elevation: 0, // Remove the elevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: white, width: 5),
            ),
            foregroundColor: Colors.white,
          ),
          child: Container(
            alignment: Alignment.topCenter,
            width: 90, // Adjust width to make the icon smaller
            height: 90, // Adjust height to make the icon smaller
            decoration: BoxDecoration(
              color: yellow,
              gradient: const LinearGradient(
                colors: [
                  yellow,
                  yellow,
                  yellow,
                  orange
                ], // Adjust colors as needed
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: orangeRed, width: 10),
            ),
            child: Center(
              child: Transform.scale(
                  scale: 0.65,
                  child: Image.asset('assets/icons/newspaper.png')),
            ),
          ),
        ),
        const StrokeText(
          text: "NEWS",
          textStyle: TextStyle(
            fontSize: 25,
            color: yellow,
            letterSpacing: 1.5,
          ),
          strokeColor: black,
          strokeWidth: 5,
        ),
      ],
    );
  }

  Widget portfolio(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Add the action to be performed when the button is pressed
            Get.to(() => const Portfolio(),
                transition: Transition.circularReveal,
                duration: const Duration(milliseconds: 800));
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor:
                Colors.transparent, // Set the background color to transparent
            elevation: 0, // Remove the elevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: white, width: 5),
            ),
            foregroundColor: Colors.white,
          ),
          child: Container(
            alignment: Alignment.topCenter,
            width: 90, // Adjust width to make the icon smaller
            height: 90, // Adjust height to make the icon smaller
            decoration: BoxDecoration(
              color: yellow,
              gradient: const LinearGradient(
                colors: [
                  yellow,
                  yellow,
                  yellow,
                  orange
                ], // Adjust colors as needed
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: orangeRed, width: 10),
            ),
            child: Center(
              child: Transform.scale(
                scale: 0.65,
                child: Image.asset(
                  'assets/icons/portfolio.png',
                ),
              ),
            ),
          ),
        ),
        const StrokeText(
          text: "PORTFOLIO",
          textStyle: TextStyle(
            fontSize: 25,
            color: yellow,
            letterSpacing: 1.5,
          ),
          strokeColor: black,
          strokeWidth: 5,
        ),
      ],
    );
  }

  Widget clothes(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Add the action to be performed when the button is pressed
            Get.to(() => const Clothes(),
                transition: Transition.circularReveal,
                duration: const Duration(milliseconds: 800));
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor:
                Colors.transparent, // Set the background color to transparent
            elevation: 0, // Remove the elevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: white, width: 5),
            ),
            foregroundColor: Colors.white,
          ),
          child: Container(
            alignment: Alignment.topCenter,
            width: 90, // Adjust width to make the icon smaller
            height: 90, // Adjust height to make the icon smaller
            decoration: BoxDecoration(
              color: yellow,
              gradient: const LinearGradient(
                colors: [
                  yellow,
                  yellow,
                  yellow,
                  orange
                ], // Adjust colors as needed
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: orangeRed, width: 10),
            ),
            child: Center(
              child: Transform.scale(
                scale: 0.65,
                child: Image.asset(
                  'assets/icons/shirt.png',
                ),
              ),
            ),
          ),
        ),
        const StrokeText(
          text: "CLOTHES",
          textStyle: TextStyle(
            fontSize: 25,
            color: yellow,
            letterSpacing: 1.5,
          ),
          strokeColor: black,
          strokeWidth: 5,
        ),
      ],
    );
  }

  Widget accomodation(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Add the action to be performed when the button is pressed
            Get.to(() => const Accomodation(),
                transition: Transition.circularReveal,
                duration: const Duration(milliseconds: 800));
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor:
                Colors.transparent, // Set the background color to transparent
            elevation: 0, // Remove the elevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: white, width: 5),
            ),
            foregroundColor: Colors.white,
          ),
          child: Container(
            alignment: Alignment.topCenter,
            width: 90, // Adjust width to make the icon smaller
            height: 90, // Adjust height to make the icon smaller
            decoration: BoxDecoration(
              color: yellow,
              gradient: const LinearGradient(
                colors: [
                  yellow,
                  yellow,
                  yellow,
                  orange
                ], // Adjust colors as needed
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: orangeRed, width: 10),
            ),
            child: Center(
              child: Transform.scale(
                scale: 0.65,
                child: Image.asset(
                  'assets/icons/house2.png',
                ),
              ),
            ),
          ),
        ),
        const StrokeText(
          text: "HOUSE",
          textStyle: TextStyle(
            fontSize: 25,
            color: yellow,
            letterSpacing: 1.5,
          ),
          strokeColor: black,
          strokeWidth: 5,
        ),
      ],
    );
  }

  Widget invest(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Add the action to be performed when the button is pressed
            Get.to(() => const Invest(),
                transition: Transition.circularReveal,
                duration: const Duration(milliseconds: 800));
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor:
                Colors.transparent, // Set the background color to transparent
            elevation: 0, // Remove the elevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: white, width: 5),
            ),
            foregroundColor: Colors.white,
          ),
          child: Container(
            alignment: Alignment.topCenter,
            width: 90, // Adjust width to make the icon smaller
            height: 90, // Adjust height to make the icon smaller
            decoration: BoxDecoration(
              color: yellow,
              gradient: const LinearGradient(
                colors: [
                  yellow,
                  yellow,
                  yellow,
                  orange
                ], // Adjust colors as needed
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: orangeRed, width: 10),
            ),
            child: Center(
              child: Transform.scale(
                scale: 0.65,
                child: Image.asset(
                  'assets/icons/invest.png',
                ),
              ),
            ),
          ),
        ),
        const StrokeText(
          text: "INVEST",
          textStyle: TextStyle(
            fontSize: 25,
            color: yellow,
            letterSpacing: 1.5,
          ),
          strokeColor: black,
          strokeWidth: 5,
        ),
      ],
    );
  }

  Padding middleMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 15, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          name(),
          Expanded(child: Container()),
          dateTime(),
        ],
        // Empty Expanded widget for empty space
      ),
    );
  }

  StrokeText name() {
    return const StrokeText(
      text: "DAVID KING",
      textStyle: TextStyle(fontSize: 25, color: yellow),
      strokeColor: darkPurple,
      strokeWidth: 6,
    );
  }

  StrokeText dateTime() {
    // Format the date using a DateFormat object
    DateFormat formatter = DateFormat('hh:mm:ss a');
    String formattedDate = formatter.format(_dateTime);
    return StrokeText(
      text: formattedDate,
      textStyle: const TextStyle(fontSize: 25, color: yellow),
      strokeColor: darkPurple,
      strokeWidth: 6,
    );
  }

  Stack backgroundMax(BuildContext context, imagePath, maxPath) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: <Widget>[
        area(context, imagePath),
        max(context, maxPath),
      ],
    );
  }

  SizedBox area(BuildContext context, imagePath) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 400,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white, width: 5),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 1.5,
                sigmaY: 1.5,
              ), // Adjust the blur intensity as needed
              child: Container(
                color:
                    Colors.black.withOpacity(0), // Adjust the opacity if needed
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned max(BuildContext context, maxPath) {
    double maxWidth =
        MediaQuery.of(context).size.width + 200; // Adjust the size as needed
    double maxHeight =
        MediaQuery.of(context).size.height - 440; // Adjust the size as needed

    return Positioned(
      top: 20, // Adjust this offset as needed
      left: (MediaQuery.of(context).size.width - maxWidth) / 2 -
          10, // Center horizontally
      child: Container(
        width: maxWidth,
        height: maxHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage(maxPath),
            fit: BoxFit.contain,
          ),
        ),
      ),
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
        Get.to(() => const HomePage());
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor:
            Colors.transparent, // Set the background color to transparent
        elevation: 0, // Remove the elevation
        shape: const CircleBorder(
          side: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      child: Container(
        width: 40, // Adjust width to make the icon smaller
        height: 40, // Adjust height to make the icon smaller
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [purple, darkPurple], // Adjust colors as needed
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20, // Adjust the size of the icon as needed
          ),
        ),
      ),
    );
  }
}
