import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:stroke_text/stroke_text.dart';

void openRevenueDialog(BuildContext context, image, stockName) {
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
            backgroundColor: white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: 400,
              height: 600,
              padding: const EdgeInsets.all(10), // Adjust padding as needed
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      width: 350,
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          Positioned(
                              top: -2, left: -10, child: revenueBack(context)),
                          revenueText(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        width: 400,
                        height: 80,
                        color: Colors.transparent,
                        child: stockDetailsLogoName(image, stockName)),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 311,
                      height: 150,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/revenue.png'),
                          fit: BoxFit.fill,
                        ),
                        border: Border.fromBorderSide(
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
                    const Text(
                      'REVENUE GROWTH',
                      style: TextStyle(
                        fontSize: 25,
                        color: purple,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'It shows an increase in a company\'s total revenue over a specific period compared to previous periods. \n\nThis growth indicates that the company is generating more income from its core business activities',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 18,
                        color: black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Center revenueText() {
  return const Center(
    child: StrokeText(
      text: "REVENUE REPORT",
      textStyle: TextStyle(fontSize: 30, color: yellow),
      strokeColor: darkPurple,
      strokeWidth: 7,
    ),
  );
}

Stack stockDetailsLogoName(image, stockName) {
  return Stack(
    children: [
      Center(
        child: Container(
          height: 70,
          width: 70,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Transform.scale(
              scale: 1.5, // Adjust the scale factor to make the image smaller
              child: Image.asset(
                image,
                width: 40, // Adjust the width of the image
                height: 40, // Adjust the height of the image
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

GestureDetector revenueBack(BuildContext context) {
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
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black,
          size: 30, // Adjust the size of the icon as needed
        ),
      ),
    ),
  );
}
