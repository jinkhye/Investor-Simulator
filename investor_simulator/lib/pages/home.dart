import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/pages/mainmenu.dart';
import 'package:stroke_text/stroke_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple,
      body: Stack(
        clipBehavior: Clip.none,
        children: Menu(context),
      ),
    );
  }

  List<Widget> Menu(BuildContext context) {
    return <Widget>[
      background(),
      max(context),
      logo(context),
      Positioned(
        bottom: 50, // Adjust this offset as needed
        left: 0,
        right: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            newGame(context),
            const SizedBox(
              height: 30,
            ),
            continueGame(context),
          ],
        ),
      ),
    ];
  }

  ElevatedButton continueGame(context) {
    return ElevatedButton(
      onPressed: () {
        // Add the action to be performed when the button is pressed
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainMenu()),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 35), // Adjust padding to make the button bigger
        backgroundColor: lightGreen,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15), // Adjust the border radius as needed
          side: const BorderSide(
            color: green,
            width: 3,
          ), // Add an outline color
        ),
      ),
      child: const StrokeText(
        text: "CONTINUE",
        textStyle: TextStyle(fontSize: 35, color: Colors.white),
        strokeColor: Colors.black,
        strokeWidth: 3,
      ),
    );
  }

  ElevatedButton newGame(context) {
    return ElevatedButton(
      onPressed: () {
        // Add the action to be performed when the button is pressed
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainMenu()),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 30), // Adjust padding to make the button bigger
        backgroundColor: yellow,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15), // Adjust the border radius as needed
          side: const BorderSide(
            color: orangeRed,
            width: 3,
          ), // Add an outline color
        ),
      ),
      child: const StrokeText(
        text: "NEW GAME",
        textStyle: TextStyle(fontSize: 35, color: Colors.white),
        strokeColor: Colors.black,
        strokeWidth: 3,
      ),
    );
  }

  Positioned max(BuildContext context) {
    double maxWidth =
        MediaQuery.of(context).size.width + 140; // Adjust the size as needed
    double maxHeight =
        MediaQuery.of(context).size.height + 140; // Adjust the size as needed

    return Positioned(
      top: 250, // Adjust this offset as needed
      left: (MediaQuery.of(context).size.width - maxWidth) / 2 -
          25, // Center horizontally
      child: Container(
        width: maxWidth,
        height: maxHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage('assets/images/Max.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Positioned logo(BuildContext context) {
    double logoWidth =
        MediaQuery.of(context).size.width + 40; // Adjust the size as needed
    double logoHeight =
        MediaQuery.of(context).size.height * 0.5; // Adjust the size as needed

    return Positioned(
      top: 35, // Adjust this offset as needed
      left: (MediaQuery.of(context).size.width - logoWidth) /
          2, // Center horizontally
      child: Container(
        width: logoWidth,
        height: logoHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Container background() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 1.5, sigmaY: 1.5), // Adjust the blur intensity as needed
        child: Container(
          color: Colors.black.withOpacity(0), // Adjust the opacity if needed
        ),
      ),
    );
  }
}
