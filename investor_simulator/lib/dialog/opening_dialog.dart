import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';

void openOpeningDialog(BuildContext context, pagecontroller) {
  final PageController pageController = pagecontroller;

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
            insetPadding: const EdgeInsets.all(15),
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: white, width: 4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: 400,
              height: 390,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: RawScrollbar(
                      thumbColor: purple,
                      controller: pageController,
                      thumbVisibility: true,
                      radius: const Radius.circular(10),
                      thickness: 10,
                      child: PageView(
                        controller: pageController,
                        children: [
                          imageContainer(context, 'assets/images/story1.png'),
                          imageContainer(context, 'assets/images/story1.1.png'),
                          imageContainer(context, 'assets/images/story2.1.png'),
                          imageContainer(context, 'assets/images/story2.2.png'),
                          imageContainer(context, 'assets/images/story2.3.png'),
                          imageContainer(context, 'assets/images/story2.4.png'),
                          imageContainer(context, 'assets/images/story3.png'),
                          imageContainer(context, 'assets/images/story4.png'),
                          imageContainer(context, 'assets/images/story5.png'),
                        ],
                      ),
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

Stack imageContainer(BuildContext context, image) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: white, width: 4),
          color: Colors.transparent,
          image:
              DecorationImage(image: AssetImage(image), fit: BoxFit.fitWidth),
        ),
      ),
      Align(alignment: Alignment.topRight, child: close(context)),
    ],
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
          color: white,
          size: 40, // Adjust the size of the icon as needed
          shadows: [
            // Add shadows to the icon
            BoxShadow(
              color: black,
              blurRadius: 20,
              offset: Offset(0, 0),
            ),
          ],
        ),
      ),
    ),
  );
}
