import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:stroke_text/stroke_text.dart';

void openKeyStatsHelpDialog(BuildContext context, pagecontroller) {
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
          Align(alignment: Alignment.centerRight, child: close(context)),
          const SizedBox(
            height: 20,
          ),
          helpText('Price-to-Earnings (P/E) ratio'),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    letterSpacing: 0,
                    wordSpacing: 0,
                    fontSize: 20,
                    color: black,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: 'What is (P/E) ratio?\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'The Price to earnings ratio measures the market price of a stock relative to its earnings per share. This metric shows how much investors are willing to pay for the profits the company generates.',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        letterSpacing: 0,
                        wordSpacing: 0,
                        fontSize: 18,
                        color: black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: '\n\nWhat does (P/E) ratio indicate?\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'Some investors believe that a high price to earnings ratio means a company is becoming expensive and possibly overvalued.\n\nA low price to earnings ratio may mean that a company is undervalued or cheap. Of course, this is not always true as sometimes a company has a high price to earnings ratio because it is growing fast and expected to grow into its high price to earnings ratio.',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        letterSpacing: 0,
                        wordSpacing: 0,
                        fontSize: 18,
                        color: black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          helpText('What to do?'),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    letterSpacing: 0,
                    wordSpacing: 0,
                    fontSize: 20,
                    color: black,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: 'Consider Growth Prospects:\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'Consider the company\'s growth prospects when interpreting the P/E ratio. A high P/E ratio may be justified if the company is expected to achieve strong earnings growth in the future. Conversely, a low P/E ratio could indicate slower growth prospects or undervaluation, but it\'s essential to evaluate the reasons behind the low ratio.',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        letterSpacing: 0,
                        wordSpacing: 0,
                        fontSize: 18,
                        color: black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text:
                          '\n\nReview the historical revenue and earnings growth rates\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'Consistent growth in revenue and earnings over time can indicate a company\'s ability to expand its operations and generate profits',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        letterSpacing: 0,
                        wordSpacing: 0,
                        fontSize: 18,
                        color: black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
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
          Align(alignment: Alignment.centerRight, child: close(context)),
          const SizedBox(
            height: 20,
          ),
          helpText('Dividend Yield'),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    letterSpacing: 0,
                    wordSpacing: 0,
                    fontSize: 20,
                    color: black,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: 'What is dividend yield?\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'The dividend yield is the ratio of a company’s annualized dividend compared to its share price.',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        letterSpacing: 0,
                        wordSpacing: 0,
                        fontSize: 18,
                        color: black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: '\n\nWhat does Dividend yield indicate?\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'It is worth noting that with a sharp drop in the price, the dividend yield will increase sharply. A high dividend yield is not always a good thing. Instead it is simply a way of seeing how much yield an investor can receive for owning a particular company.',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        letterSpacing: 0,
                        wordSpacing: 0,
                        fontSize: 18,
                        color: black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
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
          Align(alignment: Alignment.centerRight, child: close(context)),
          const SizedBox(
            height: 20,
          ),
          helpText('Market Capitalization'),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    letterSpacing: 0,
                    wordSpacing: 0,
                    fontSize: 20,
                    color: black,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: 'What is Market capitalization?\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'Investors use market capitalization to gauge company size, influencing how they perceive risk and compare companies.\n\nLarge-cap companies, with over \$10 billion in capitalization, are seen as stable and attractive due to their size and liquidity.\n\nMid-cap companies, valued between \$2 billion and \$10 billion, offer growth potential but can be riskier. However, investments in such companies can be risky, as mid-cap companies are sometimes as small as they are for a reason and growth is a challenge.\n\nSmall-cap companies, with capitalization from \$300 million to \$2 billion, are more volatile and risky, often influenced by investor sentiment.',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        letterSpacing: 0,
                        wordSpacing: 0,
                        fontSize: 18,
                        color: black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
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
