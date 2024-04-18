import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/menu/topMenu.dart';
import 'package:investor_simulator/models/accommodation_model.dart';
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
  List<AccomodationModel> accommodation = [];

  @override
  Widget build(BuildContext context) {
    final imagePath = Provider.of<GameProvider>(context);

    accommodation = imagePath.accomodation;

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
        accommodationText(),
        Expanded(
          child: _accommodationSection(imagePath),
        ),
      ],
    );
  }

  Column _accommodationSection(imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: accommodation.length,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(left: 20, right: 20),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: lockedAccomodation(index, context, imagePath),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget lockedAccomodation(index, context, GameProvider imagePath) {
    int currentLevel = imagePath.level;
    if (currentLevel >= accommodation[index].lvl) {
      return accomodationStack(index, context, imagePath);
    } else {
      return Stack(
        children: [
          accomodationStack(index, context, imagePath),
          Container(
            height: 160,
            width: 400,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: StrokeText(
                text: 'UNLOCK AT LVL ${accommodation[index].lvl}',
                textStyle: const TextStyle(
                  fontSize: 30,
                  color: yellow,
                  letterSpacing: 1,
                ),
                strokeColor: Colors.black,
                strokeWidth: 5,
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget accomodationStack(int index, BuildContext context, imagePath) {
    if (imagePath.accommodationUse > index) {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 190,
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
              height: 120,
              width: 320,
              decoration: BoxDecoration(
                color: white,
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
                      text: accommodation[index].name.toUpperCase(),
                      textStyle: const TextStyle(
                          fontSize: 25,
                          color: black,
                          fontWeight: FontWeight.w100,
                          letterSpacing: 1),
                      strokeColor: darkPurple,
                      strokeWidth: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '(+\$${accommodation[index].income})  ',
                          style: const TextStyle(
                            fontSize: 16,
                            color: green,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Helvetica',
                          ),
                        ),
                        Text(
                          'Lvl ${accommodation[index].current}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Helvetica',
                          ),
                        ),
                      ],
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
                        Text(
                          '\$${accommodation[index].upgradePrice.round()}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: green,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Helvetica',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            left: 30,
            child: Row(
              children: [
                const Text(
                  'Earning: ',
                  style: TextStyle(
                    fontSize: 16,
                    color: black,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Helvetica',
                  ),
                ),
                Text(
                  '\$${accommodation[index].current * accommodation[index].income}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: green,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Helvetica',
                  ),
                ),
                const Text(
                  ' / Hour',
                  style: TextStyle(
                    fontSize: 16,
                    color: black,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Helvetica',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            right: 14,
            child: accept(context, index, imagePath, accommodation[index].lvl),
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
                  image: AssetImage(accommodation[index].iconPath),
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
      );
    } else {
      return Stack(
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
                      text: accommodation[index].name.toUpperCase(),
                      textStyle: const TextStyle(
                          fontSize: 25,
                          color: black,
                          fontWeight: FontWeight.w100,
                          letterSpacing: 1),
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
                        Text(
                          '\$${accommodation[index].price}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: green,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Helvetica',
                          ),
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
            child: accept(context, index, imagePath, accommodation[index].lvl),
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
                  image: AssetImage(accommodation[index].iconPath),
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
      );
    }
  }

  Widget accept(
      BuildContext context, index, GameProvider imagePath, int requiredLvl) {
    return ElevatedButton(
      onPressed: () {
        String image = accommodation[index].iconPath;
        double price = accommodation[index].price.toDouble();
        // Add the action to be performed when the button is pressed
        if (imagePath.money >= price &&
            imagePath.accommodationUse != index &&
            index > imagePath.accommodationUse &&
            imagePath.level >= requiredLvl &&
            imagePath.accommodationUse == index - 1) {
          imagePath.setImagePath(image);
          imagePath.subtractMoney(price);
          imagePath.setAccommodationUse(index);
        } else if (imagePath.money >= accommodation[index].upgradePrice) {
          imagePath.subtractMoney(accommodation[index].upgradePrice.toDouble());
          imagePath.addAccomodationLevel(index);
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor:
            Colors.transparent, // Set the background color to transparent
        elevation: 0, // Remove the elevation
      ),
      child: getBuyButton(index, imagePath, requiredLvl),
    );
  }

  Widget getBuyButton(index, GameProvider imagePath, int requiredLvl) {
    if (imagePath.accommodationUse == index) {
      return Container(
        alignment: Alignment.center,
        height: 35,
        width: 100,
        decoration: BoxDecoration(
          color: yellow,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: orangeRed,
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
        child: const StrokeText(
          text: 'SELECTED',
          textStyle: TextStyle(fontSize: 18, color: white),
          strokeColor: black,
          strokeWidth: 4,
        ),
      );
    } else if (imagePath.level < requiredLvl) {
      return Container(
        alignment: Alignment.center,
        height: 35,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.grey[400] ?? Colors.grey,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey[500] ?? Colors.grey,
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
        child: const StrokeText(
          text: 'LOCKED',
          textStyle: TextStyle(fontSize: 18, color: white),
          strokeColor: black,
          strokeWidth: 4,
        ),
      );
    } else if (imagePath.accommodationUse == index - 1) {
      return Container(
        alignment: Alignment.center,
        height: 35,
        width: 100,
        decoration: BoxDecoration(
          color: lightGreen,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: green,
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
        child: const StrokeText(
          text: 'ACCEPT',
          textStyle: TextStyle(fontSize: 18, color: white),
          strokeColor: black,
          strokeWidth: 4,
        ),
      );
    } else if (imagePath.accommodationUse > index) {
      return Container(
        alignment: Alignment.center,
        height: 35,
        width: 100,
        decoration: BoxDecoration(
          color: lightGreen,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: green,
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
        child: const StrokeText(
          text: 'UPGRADE',
          textStyle: TextStyle(fontSize: 18, color: white),
          strokeColor: black,
          strokeWidth: 4,
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        height: 35,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.grey[400] ?? Colors.grey,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey[500] ?? Colors.grey,
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
        child: const StrokeText(
          text: 'LOCKED',
          textStyle: TextStyle(fontSize: 18, color: white),
          strokeColor: black,
          strokeWidth: 4,
        ),
      );
    }
  }

  Container accommodationText() {
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
