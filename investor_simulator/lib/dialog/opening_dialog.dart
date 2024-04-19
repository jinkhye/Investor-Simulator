import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/provider/game_provider.dart';
import 'package:provider/provider.dart';

void openOpeningDialog(BuildContext context) {
  // Create a PageController
  final PageController pageController = PageController();

  // Show the general dialog with the custom stateful widget
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
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
              side: const BorderSide(color: Colors.white, width: 4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: _OpeningDialogWidget(pageController: pageController),
          ),
        ),
      );
    },
  );
}

class _OpeningDialogWidget extends StatefulWidget {
  final PageController pageController;

  const _OpeningDialogWidget({required this.pageController});

  @override
  __OpeningDialogWidgetState createState() => __OpeningDialogWidgetState();
}

class __OpeningDialogWidgetState extends State<_OpeningDialogWidget> {
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    // Listen to the page controller to update the current page index
    widget.pageController.addListener(() {
      setState(() {
        _currentPageIndex = widget.pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.8,
      child: Stack(
        children: [
          PageView(
            controller: widget.pageController,
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
          Align(
            alignment: Alignment.topRight,
            child: close(context),
          ),
          // Conditionally show buttons based on the current page index
          if (_currentPageIndex == 0) // Show only next button on page 0
            Align(
              alignment: Alignment.centerRight,
              child: next(context, widget.pageController),
            )
          else if (_currentPageIndex == 8) // Show only next button on page 0
            Align(
              alignment: Alignment.centerLeft,
              child: back(context, widget.pageController),
            )
          else if (_currentPageIndex > 0 &&
              _currentPageIndex <
                  8) // Show back and next buttons on pages other than 0 and 8
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  back(context, widget.pageController),
                  next(context, widget.pageController),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

Widget imageContainer(BuildContext context, String imagePath) {
  return Image.asset(
    imagePath,
    fit: BoxFit.fill,
  );
}

Widget close(BuildContext context) {
  final provider = Provider.of<GameProvider>(context, listen: false);
  return Container(
    decoration: BoxDecoration(
      // Define the shadow using boxShadow
      boxShadow: [
        BoxShadow(
          color: black.withOpacity(0.3), // Color of the shadow
          blurRadius: 8, // Blur radius of the shadow
          offset: const Offset(2, 2), // Offset of the shadow
        ),
      ],
      // Set the shape of the container as a circle
      shape: BoxShape.circle,
    ),
    child: IconButton(
      icon: const Icon(Icons.close),
      color: white,
      iconSize: 40,
      onPressed: () {
        Navigator.pop(context);
        provider.setClose(true);
        provider.setOpenCount(1);
      },
    ),
  );
}

Widget back(BuildContext context, PageController pageController) {
  return GestureDetector(
    onTap: () {
      // Use the pageController argument to navigate to the previous page
      if (pageController.page != null && pageController.page! > 0) {
        pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          height: 50,
          width: 25,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: black,
                blurRadius: 30.0,
                spreadRadius: 0.0,
                offset: Offset(0.0, 0.0),
              ),
            ],
            image: DecorationImage(
              image: AssetImage('assets/icons/back.png'),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                white, // Change this to the color you want to apply
                BlendMode
                    .srcIn, // Use BlendMode to determine how to apply the color
              ),
            ),
          )),
    ),
  );
}

Widget next(BuildContext context, PageController pageController) {
  return GestureDetector(
    onTap: () {
      // Use the pageController argument to navigate to the previous page
      if (pageController.page != null && pageController.page! < 8) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          height: 50,
          width: 25,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: black,
                blurRadius: 30.0,
                spreadRadius: 0.0,
                offset: Offset(0.0, 0.0),
              ),
            ],
            image: DecorationImage(
              image: AssetImage('assets/icons/next.png'),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                white, // Change this to the color you want to apply
                BlendMode
                    .srcIn, // Use BlendMode to determine how to apply the color
              ),
            ),
          )),
    ),
  );
}
