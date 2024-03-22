import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:stroke_text/stroke_text.dart';

void openStockHelpDialog(BuildContext context, pagecontroller) {
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
            backgroundColor: Colors.transparent,
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
                    child: RawScrollbar(
                      thumbColor: purple,
                      controller: pageController,
                      thumbVisibility: true,
                      radius: const Radius.circular(10),
                      thickness: 10,
                      child: PageView(
                        controller: pageController,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: yellow,
                            ),
                            child: Scrollbar(child: helpPage1(context)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: yellow,
                            ),
                            child: Scrollbar(child: helpPage2(context)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: yellow,
                            ),
                            child: Scrollbar(child: helpPage3(context)),
                          ),
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

SingleChildScrollView helpPage3(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Stack(
            children: [
              helpText('CRYPTOCURRENCY'),
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
              image: const DecorationImage(
                image: AssetImage('assets/images/cryptohelp.png'),
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
            height: 20,
          ),
          Container(
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: white,
            ),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Cryptocurrency is a digital or virtual currency that uses cryptography for security.Cryptocurrency investing can be highly unpredictive and risky.\n\nPrices of cryptocurrencies can experience rapid fluctuations based on factors such as market demand, regulatory developments, technological advancements, and investor sentiment.',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  letterSpacing: 0,
                  wordSpacing: 0,
                  fontSize: 20,
                  color: black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
}

SingleChildScrollView helpPage2(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Stack(
            children: [
              helpText('ETF'),
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
              image: const DecorationImage(
                image: AssetImage('assets/images/etfhelp.png'),
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
            height: 20,
          ),
          Container(
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: white,
            ),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'ETFs are investment funds that hold a collection of assets such as stocks, bonds, or commodities. When you buy shares of an ETF, you\'re essentially buying a piece of a diversified portfolio of assets.\n\nETFs reduce risk compared to investing in individual stocks. However, there are still risks associated with ETF investing, including market risk, sector risk, and tracking error risk',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  letterSpacing: 0,
                  wordSpacing: 0,
                  fontSize: 20,
                  color: black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
}

SingleChildScrollView helpPage1(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Stack(
            children: [
              helpText('STOCKS'),
              Positioned(top: -2, right: 0, child: close(context)),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/stockhelp1.png'),
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
                width: 10,
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/stockhelp2.png'),
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
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: white,
            ),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Stocks represent ownership in a company. When you buy a stock, you\'re buying a small piece of that company.\n\nInvesting in stocks can be risky because the value of a company\'s stock can go up or down based on various factors like the company\'s performance.\n\nIf the company performs well, the value of your investment may increase, but if the company struggles or faces challenges, the value of your investment could decrease.',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  letterSpacing: 0,
                  wordSpacing: 0,
                  fontSize: 20,
                  color: black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
}

Center helpText(String text) {
  return Center(
    child: StrokeText(
      text: text,
      textStyle: const TextStyle(fontSize: 30, color: white, letterSpacing: 1),
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
