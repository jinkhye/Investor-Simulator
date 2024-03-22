import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/models/news_model.dart';
import 'package:investor_simulator/pages/news_assessment.dart';
import 'package:stroke_text/stroke_text.dart';

void openNewsDialog(BuildContext context, List<NewsModel> news, index) {
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
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: 400,
              height: 600,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: white,
                          ),
                          child:
                              Scrollbar(child: newsPage(context, news, index)),
                        ),
                      ],
                    ),
                  ),
                  // Add other widgets if needed below the Scrollbar
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

SingleChildScrollView newsPage(
    BuildContext context, List<NewsModel> news, index) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Stack(
            children: [
              helpText('NEWS'),
              Positioned(top: -2, right: 0, child: close(context)),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(news[index].iconPath),
                fit: BoxFit.fill,
              ),
              border: const Border.fromBorderSide(
                BorderSide(
                  color: black,
                  width: 4,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 295,
            child: Text(
              news[index].name,
              style: const TextStyle(
                letterSpacing: 0.5,
                fontSize: 20,
                color: purple,
                overflow: TextOverflow.clip,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                news[index].description,
                style: const TextStyle(
                  fontFamily: 'Helvetica',
                  letterSpacing: 0,
                  wordSpacing: 0,
                  fontSize: 16,
                  color: black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          aiAssessment(context, news, index),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
}

ElevatedButton aiAssessment(BuildContext context, List<NewsModel> news, index) {
  return ElevatedButton(
    onPressed: () {
      Get.to(() => NewsAssessment(news: news, index: index),
          transition: Transition.circularReveal,
          duration: const Duration(milliseconds: 800));
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      backgroundColor:
          Colors.transparent, // Set the background color to transparent
      elevation: 0, // Remove the elevation
    ),
    child: Container(
      alignment: Alignment.center,
      height: 70,
      width: 280,
      decoration: BoxDecoration(
        color: yellow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: orangeRed,
          width: 3,
        ),
      ),
      child: const StrokeText(
        text: 'BEGIN AI ASSESSMENT',
        textStyle: TextStyle(
          fontSize: 24,
          color: white,
          letterSpacing: 1,
        ),
        strokeColor: black,
        strokeWidth: 4,
      ),
    ),
  );
}

Center helpText(String text) {
  return Center(
    child: StrokeText(
      text: text,
      textStyle: const TextStyle(fontSize: 30, color: yellow, letterSpacing: 1),
      strokeColor: darkPurple,
      strokeWidth: 7,
    ),
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
