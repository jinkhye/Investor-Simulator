import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/menu/topMenu.dart';
import 'package:investor_simulator/models/clothes_model.dart';
import 'package:investor_simulator/provider/game_provider.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'mainmenu.dart';

class Clothes extends StatefulWidget {
  const Clothes({super.key});

  @override
  State<Clothes> createState() => _ClothesState();
}

class _ClothesState extends State<Clothes> {
  List<ClothesModel> clothes = [];

  void _getInitialInfo() {
    clothes = ClothesModel.getClothes();
  }

  @override
  Widget build(BuildContext context) {
    final maxPath = Provider.of<GameProvider>(context);

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
          child: gameMenu(context, maxPath),
        ),
      ),
    );
  }

  Column gameMenu(BuildContext context, imagePath) {
    return Column(
      children: <Widget>[
        topMenu(context),
        clothesText(),
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
            itemCount: clothes.length,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(left: 20, right: 20),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: lockedClothes(index, context, imagePath),
              );
            },
          ),
        ),
      ],
    );
  }

  Stack lockedClothes(int index, BuildContext context, imagePath) {
    int currentLevel = imagePath.level;
    if (currentLevel >= clothes[index].lvl) {
      return clothesStack(index, context, imagePath);
    } else {
      return Stack(
        children: [
          clothesStack(index, context, imagePath),
          Container(
            height: 160,
            width: 400,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: StrokeText(
                text: 'UNLOCK AT LVL ${clothes[index].lvl}',
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

  Stack clothesStack(int index, BuildContext context, imagePath) {
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
                    text: clothes[index].name.toUpperCase(),
                    textStyle: const TextStyle(
                        fontSize: 25,
                        color: black,
                        fontWeight: FontWeight.w100,
                        letterSpacing: 0.3),
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
                        '\$${clothes[index].price}',
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
          child: accept(context, index, imagePath),
        ),
        Positioned(
          top: 0,
          left: 10,
          child: Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [purple, darkPurple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              color: purple,
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(clothes[index].iconPath),
                fit: BoxFit.contain,
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

  ElevatedButton accept(BuildContext context, index, GameProvider maxPath) {
    return ElevatedButton(
      onPressed: () {
        String image = clothes[index].iconPath;
        double price = clothes[index].price.toDouble();
        // Add the action to be performed when the button is pressed
        if (maxPath.money >= price &&
            maxPath.clothesUse != index &&
            maxPath.level >= clothes[index].lvl &&
            index > maxPath.clothesUse &&
            maxPath.clothesUse == index - 1) {
          maxPath.setMaxPath(image);
          maxPath.subtractMoney(price);
          maxPath.setClothesUse(index);
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor:
            Colors.transparent, // Set the background color to transparent
        elevation: 0, // Remove the elevation
      ),
      child: getBuyButton(index, maxPath, clothes[index].lvl),
    );
  }

  Widget getBuyButton(index, GameProvider imagePath, int requiredLvl) {
    if (imagePath.clothesUse == index) {
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
    } else if (imagePath.clothesUse == index - 1) {
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
    } else if (imagePath.clothesUse > index) {
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
          text: 'BOUGHT',
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

  Container clothesText() {
    return Container(
      alignment: Alignment.topCenter,
      color: Colors.transparent,
      width: 300,
      height: 60,
      child: const StrokeText(
        text: "CLOTHES",
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
