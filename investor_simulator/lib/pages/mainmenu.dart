import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/pages/home.dart';
import 'package:investor_simulator/pages/invest.dart';
import 'package:stroke_text/stroke_text.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

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
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: gameMenu(context),
        ),
      ),
    );
  }

  Column gameMenu(BuildContext context) {
    return Column(
      children: <Widget>[
        topMenu(context),
        middleMenu(context),
        const SizedBox(
          height: 10,
        ),
        backgroundMax(context),
        const SizedBox(
          height: 10,
        ),
        bottomMenu(context),
      ],
    );
  }

  Padding bottomMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 15, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          invest(context),
          Container(
            width: 20,
          ),
          portfolio(context),
        ],
      ),
    );
  }

  ElevatedButton portfolio(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add the action to be performed when the button is pressed
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Invest()),
        );
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

  ElevatedButton invest(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add the action to be performed when the button is pressed
        Get.to(Invest(),
            transition: Transition.circularReveal,
            duration: Duration(milliseconds: 800));
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
        Get.to(HomePage());
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
          settings(context),
          Expanded(child: Container()), // Empty Expanded widget for empty space
          money()
        ],
      ),
    );
  }

  Stack backgroundMax(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: <Widget>[
        area(),
        max(context),
      ],
    );
  }

  Container area() {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 450,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/Streets.png',
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

  Positioned max(BuildContext context) {
    double maxWidth =
        MediaQuery.of(context).size.width + 200; // Adjust the size as needed
    double maxHeight =
        MediaQuery.of(context).size.height - 300; // Adjust the size as needed

    return Positioned(
      top: 20, // Adjust this offset as needed
      left: (MediaQuery.of(context).size.width - maxWidth) / 2 -
          10, // Center horizontally
      child: Container(
        width: maxWidth,
        height: maxHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage('assets/images/Maxtshirt.png'),
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

  ElevatedButton settings(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add the action to be performed when the button is pressed
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor:
              Colors.transparent, // Set the background color to transparent
          elevation: 0, // Remove the elevation
          shape: const CircleBorder()),
      child: Container(
        width: 50, // Adjust width to make the icon smaller
        height: 50, // Adjust height to make the icon smaller
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/images/settings.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
