import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/menu/topMenu.dart';
import 'package:investor_simulator/models/accomodation_model.dart';
import 'package:investor_simulator/provider/game_provider.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'mainmenu.dart';

class Accomodation extends StatefulWidget {
  const Accomodation({super.key});

  @override
  State<Accomodation> createState() => _AccomodationState();
}

class _AccomodationState extends State<Accomodation> {
  List<AccomodationModel> accomodation = [];

  void _getInitialInfo() {
    accomodation = AccomodationModel.getAccomodation();
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = Provider.of<GameProvider>(context);

    _getInitialInfo();

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
          child: gameMenu(context, imagePath),
        ),
      ),
    );
  }

  Column gameMenu(BuildContext context, imagePath) {
    return Column(
      children: <Widget>[
        topMenu(context),
        accomodationText(),
        Expanded(
          child: _accomodationSection(imagePath),
        ),
      ],
    );
  }

  Column _accomodationSection(imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: accomodation.length,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(left: 20, right: 20),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: 170,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      child: Container(
                        alignment: Alignment.topRight,
                        height: 100,
                        width: 320,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              StrokeText(
                                text: accomodation[index].name,
                                textStyle:
                                    const TextStyle(fontSize: 25, color: black),
                                strokeColor: darkPurple,
                                strokeWidth: 0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    'assets/images/money.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(width: 5),
                                  StrokeText(
                                    text: "${accomodation[index].price}/month",
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      color: black,
                                    ),
                                    strokeColor: white,
                                    strokeWidth: 4,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 14,
                      child: accept(context, index, imagePath),
                    ),
                    Positioned(
                      top: 0,
                      left: 10,
                      child: Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          color: purple,
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(accomodation[index].iconPath),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: darkPurple,
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
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
        String image = accomodation[index].iconPath;
        // Add the action to be performed when the button is pressed
        imagePath.setImagePath(image);
        imagePath.subtractMoney(accomodation[index].price.toDouble());
        imagePath.setAccomodationUse(index);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor:
            Colors.transparent, // Set the background color to transparent
        elevation: 0, // Remove the elevation
      ),
      child: Container(
        alignment: Alignment.center,
        height: 35,
        width: 100,
        decoration: BoxDecoration(
          color: getButtonColor(index, imagePath),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: getStrokeColor(index, imagePath),
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: StrokeText(
          text: getText(index, imagePath),
          textStyle: const TextStyle(fontSize: 18, color: white),
          strokeColor: black,
          strokeWidth: 4,
        ),
      ),
    );
  }

  Color getButtonColor(int index, imagePath) {
    if (imagePath.accomodationUse == index) {
      return yellow;
    } else {
      return lightGreen;
    }
  }

  Color getStrokeColor(int index, imagePath) {
    if (imagePath.accomodationUse == index) {
      return orangeRed;
    } else {
      return green;
    }
  }

  String getText(int index, imagePath) {
    if (imagePath.accomodationUse == index) {
      return 'SELECTED';
    } else {
      return 'ACCEPT';
    }
  }

  Container accomodationText() {
    return Container(
      alignment: Alignment.topCenter,
      color: Colors.transparent,
      width: 300,
      height: 60,
      child: const StrokeText(
        text: "ACCOMODATION",
        textStyle: TextStyle(fontSize: 40, color: yellow),
        strokeColor: darkPurple,
        strokeWidth: 7,
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
        Get.to(() => const MainMenu(),
            transition: Transition.circularReveal,
            duration: const Duration(milliseconds: 800));
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
