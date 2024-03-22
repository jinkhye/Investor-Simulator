import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/dialog/news_dialog.dart';

import 'package:investor_simulator/invest_page/stocks.dart';
import 'package:investor_simulator/menu/topMenu.dart';
import 'package:investor_simulator/models/news_model.dart';

import 'package:stroke_text/stroke_text.dart';
import 'mainmenu.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              topMenu(context),
              Expanded(
                child: stockMenu(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column stockMenu(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: [
            Center(child: stocksText()),
            Positioned(
              right: 10,
              top: 5,
              child: help(context),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(child: _stocksSection(context)),
        const SizedBox(height: 20),
      ],
    );
  }

  Color getColour(String percentage) {
    if (percentage.contains('-')) {
      return red;
    } else {
      return lightGreen;
    }
  }

  Column _stocksSection(BuildContext context) {
    List<NewsModel> news = NewsModel.getNews();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: news.length,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(left: 20, right: 20),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topRight,
                      height: 100,
                      width: 330,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 125,
                      child: SizedBox(
                        width: 215,
                        child: StrokeText(
                          text: news[index].name,
                          textStyle: const TextStyle(
                            letterSpacing: 0.5,
                            fontSize: 16,
                            color: purple,
                            overflow: TextOverflow.clip,
                          ),
                          strokeColor: white,
                          strokeWidth: 4,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 30,
                      child: Container(
                        height: 85,
                        width: 85,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: white,
                          border: Border.all(
                            color: darkPurple,
                            width: 4,
                          ),
                          image: DecorationImage(
                            image: AssetImage(news[index].iconPath),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Positioned(child: accept(context, index, news)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  ElevatedButton accept(BuildContext context, index, List<NewsModel> news) {
    return ElevatedButton(
      onPressed: () {
        openNewsDialog(context, news, index);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor:
            Colors.transparent, // Set the background color to transparent
        elevation: 0, // Remove the elevation
      ),
      child: Container(
        height: 115,
        width: 330,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
      ),
    );
  }

  StrokeText stocksText() {
    return const StrokeText(
      text: "TRENDING NEWS",
      textStyle: TextStyle(fontSize: 40, color: yellow),
      strokeColor: darkPurple,
      strokeWidth: 7,
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
        Get.to(() => const MainMenu());
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
