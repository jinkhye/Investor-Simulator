import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/pages/clothes.dart';
import 'package:investor_simulator/pages/home.dart';
import 'package:investor_simulator/pages/accomodation.dart';
import 'package:investor_simulator/provider/counter_provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatefulWidget {
  MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
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
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: gameMenu(context, imagePath, maxPath),
          ),
        ),
      ),
    );
  }

  Column gameMenu(BuildContext context, imagePath, maxPath) {
    return Column(
      children: <Widget>[
        topMenu(context),
        middleMenu(context),
        const SizedBox(
          height: 10,
        ),
        backgroundMax(context, imagePath, maxPath),
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
            accomodation(context),
            const SizedBox(width: 20),
            clothes(context),
          ],
        ),
      ),
    );
  }

  ElevatedButton portfolio(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add the action to be performed when the button is pressed
      },
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor:
              Colors.transparent, // Set the background color to transparent
          elevation: 0, // Remove the elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: white, width: 7),
          )),
      child: Container(
        alignment: Alignment.topCenter,
        width: 100, // Adjust width to make the icon smaller
        height: 100, // Adjust height to make the icon smaller
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [yellow, orange], // Adjust colors as needed
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: orangeRed, width: 12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/portfolio.svg',
              width: 40,
              height: 40,
            ),
            const StrokeText(
              text: "PORTFOLIO",
              textStyle: TextStyle(fontSize: 17, color: white),
              strokeColor: black,
              strokeWidth: 5,
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton clothes(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add the action to be performed when the button is pressed
        Get.to(Clothes(),
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
            side: const BorderSide(color: white, width: 7),
          )),
      child: Container(
        alignment: Alignment.topCenter,
        width: 100, // Adjust width to make the icon smaller
        height: 100, // Adjust height to make the icon smaller
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [yellow, orange], // Adjust colors as needed
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: orangeRed, width: 12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/shirt.svg',
              width: 40,
              height: 40,
            ),
            const StrokeText(
              text: "CLOTHES",
              textStyle: TextStyle(fontSize: 20, color: white),
              strokeColor: black,
              strokeWidth: 5,
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton accomodation(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add the action to be performed when the button is pressed
        Get.to(Accomodation(),
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
            side: const BorderSide(color: white, width: 7),
          )),
      child: Container(
        alignment: Alignment.topCenter,
        width: 100, // Adjust width to make the icon smaller
        height: 100, // Adjust height to make the icon smaller
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [yellow, orange], // Adjust colors as needed
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: orangeRed, width: 12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/house.svg',
              width: 40,
              height: 40,
            ),
            const StrokeText(
              text: "ACCOMODATION",
              textStyle: TextStyle(fontSize: 13, color: white),
              strokeColor: black,
              strokeWidth: 5,
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton invest(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add the action to be performed when the button is pressed
        Get.to(Accomodation(),
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
            side: const BorderSide(color: white, width: 7),
          )),
      child: Container(
        alignment: Alignment.topCenter,
        width: 100, // Adjust width to make the icon smaller
        height: 100, // Adjust height to make the icon smaller
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [yellow, orange], // Adjust colors as needed
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: orangeRed, width: 12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/graph.svg',
              width: 40,
              height: 40,
            ),
            const StrokeText(
              text: "INVEST",
              textStyle: TextStyle(fontSize: 20, color: white),
              strokeColor: black,
              strokeWidth: 5,
            ),
          ],
        ),
      ),
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
          pause(context),
          play(context),
          fastForward(context),
          Expanded(child: Container()),
          date(),
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

  StrokeText date() {
    return const StrokeText(
      text: "15 MAC 2024",
      textStyle: TextStyle(fontSize: 18, color: yellow),
      strokeColor: darkPurple,
      strokeWidth: 6,
    );
  }

  Widget pause(context) {
    return GestureDetector(
      onTap: () {
        Get.offAll(const HomePage());
      },
      child: SizedBox(
        width: 36,
        height: 36,
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/pause.png'),
              fit: BoxFit.contain, // Adjust the fit to contain
            ),
          ),
        ),
      ),
    );
  }

  Widget play(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: SizedBox(
        width: 36,
        height: 36,
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/play.png'),
              fit: BoxFit.contain, // Adjust the fit to contain
            ),
          ),
        ),
      ),
    );
  }

  Widget fastForward(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: SizedBox(
        width: 36,
        height: 36,
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/fastForward.png'),
              fit: BoxFit.contain, // Adjust the fit to contain
            ),
          ),
        ),
      ),
    );
  }

  Padding topMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: <Widget>[
          back(context),
          Expanded(child: Container()), // Empty Expanded widget for empty space
          money()
        ],
      ),
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

  Container area(BuildContext context, imagePath) {
    return Container(
      height: MediaQuery.of(context).size.height - 400,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
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
        Get.to(HomePage());
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
