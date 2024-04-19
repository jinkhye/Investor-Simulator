// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/dialog/stock_dialog/crypto_dialog.dart';
import 'package:stroke_text/stroke_text.dart';

void openStockKeyStatsHelpDialog(BuildContext context, pagecontroller) {
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
                            child: Scrollbar(child: pegHelp(context)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: yellow,
                            ),
                            child: Scrollbar(child: forwardPEhelp(context)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: yellow,
                            ),
                            child: Scrollbar(child: priceToBookHelp(context)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: yellow,
                            ),
                            child: Scrollbar(child: marketStateHelp(context)),
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

void openETFKeyStatsHelpDialog(BuildContext context, pagecontroller) {
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
                            child: Scrollbar(child: priceToBookHelp(context)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: yellow,
                            ),
                            child: Scrollbar(child: marketStateHelp(context)),
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

void openForexKeyStatsHelpDialog(BuildContext context, pagecontroller) {
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
                            child: Scrollbar(child: marketStateHelp(context)),
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

void openCryptoKeyStatsHelpDialog(BuildContext context, pagecontroller) {
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
                            child: Scrollbar(child: marketCapRankHelp(context)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: yellow,
                            ),
                            child:
                                Scrollbar(child: marketCapChangeHelp(context)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: yellow,
                            ),
                            child: Scrollbar(child: totalVolumeHelp(context)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: yellow,
                            ),
                            child: Scrollbar(
                                child: circulatingSupplyHelp(context)),
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

SingleChildScrollView circulatingSupplyHelp(BuildContext context) {
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
          helpText('CIRCULATING SUPPLY'),
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
                      text: 'What is Circulating Supply?\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'Circulating supply represents the number of units or tokens of an asset that are currently in circulation and available for trading in the market. It excludes locked or reserved units that are not accessible for trading. Circulating supply helps determine an asset\'s scarcity, as a lower circulating supply may imply greater scarcity and potentially higher value per unit. Investors use circulating supply to calculate metrics such as market capitalization and to assess the potential impact of changes in supply on the asset\'s price.',
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

SingleChildScrollView totalVolumeHelp(BuildContext context) {
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
          helpText('TOTAL VOLUME'),
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
                      text: 'What is Total Volume?\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'Total volume refers to the total amount of an asset that has been traded within a specific timeframe, usually within the last 24 hours. It includes both buy and sell transactions and is a key indicator of market activity and liquidity. High trading volume can suggest strong interest and liquidity in the asset, while low volume may indicate a lack of interest or liquidity. Investors use total volume as a measure of an asset\'s trading activity and to assess market trends and potential investment opportunities.',
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

SingleChildScrollView marketCapChangeHelp(BuildContext context) {
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
          helpText('MARKET CAP CHANGE PERCENTAGE (24H)'),
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
                      text: 'What is Market Cap Change Percentage (24H)?\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'Market cap change percentage (24H) measures the change in the market capitalization of an asset over a 24-hour period. It is expressed as a percentage and is calculated by comparing the current market cap with the market cap 24 hours ago. This metric provides an indication of how the market value of an asset has fluctuated over the past day.\n\nA positive percentage change indicates an increase in market cap, suggesting that the asset\'s market value has grown in the last 24 hours. This could be due to a rise in the asset\'s price or an increase in its supply. A negative percentage change indicates a decrease in market cap, which could result from a drop in the asset\'s price or a reduction in its supply.\n\nInvestors use market cap change percentage (24H) to assess the short-term performance of an asset. It helps them gauge recent market sentiment and make more informed decisions about buying, selling, or holding an asset based on its recent trends.',
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

SingleChildScrollView marketCapRankHelp(BuildContext context) {
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
          helpText('MARKET CAP RANK'),
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
                      text: 'What is Market Cap Rank?\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'Market cap rank refers to a classification system that ranks assets based on their market capitalization, which is the total market value of the asset\'s outstanding units or tokens. This is calculated by multiplying the current unit or token price by the total supply. Assets are ranked based on their market capitalization, with a lower rank number indicating a higher market cap.\n\nFor example, an asset with a market cap rank of 1 has the highest market capitalization in the market. An asset with a market cap rank of 2 has the second-highest market cap, and so on.\n\nMarket cap rank provides a useful overview of the top-performing assets by market value. By considering an asset\'s rank, investors can focus on assets with the most significant market capitalization and gauge their relative position within the overall market. It can also help investors identify leading assets in terms of size and potential influence on the market.',
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

SingleChildScrollView marketStateHelp(BuildContext context) {
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
          helpText('MARKET STATE'),
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
                      text: 'What is Market State?\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'In the world of trading, the market state is an important aspect that can affect the availability and prices of securities. The market state refers to the different periods of the trading day: pre-market, regular market, and post-market. Each state has its own characteristics and trading activities.',
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
          helpText('PRE-MARKET'),
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
                      text:
                          'Pre-market trading occurs before the regular market opens, typically a few hours in advance. This is when some electronic exchanges begin to allow trades, usually starting around 4 a.m. or 5 a.m. in the local time zone. During this time, traders can place orders and buy or sell securities. However, trading volume tends to be lower, which can lead to greater price volatility and larger bid-ask spreads. News releases and economic data often influence trading activity during this period.',
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
          helpText('REGULAR MARKET'),
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
                      text:
                          'The regular market is the primary trading session when most buying and selling occurs. This is the period when exchanges are open for trading, typically from 9:30 a.m. to 4 p.m. in the local time zone. During this time, there is higher liquidity and more market participants, leading to smaller bid-ask spreads and generally more stable prices. This is the most active and efficient time for trading securities.',
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
          helpText('POST-MARKET'),
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
                      text:
                          'Post-market trading takes place after the regular market has closed, usually from 4 p.m. to 8 p.m. in the local time zone. Similar to pre-market trading, trading volume in post-market hours is lower, which can result in greater price volatility and wider bid-ask spreads. This time allows traders to react to late-breaking news or earnings reports released after the market close.',
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
                      text:
                          'While traders can take advantage of all three market states, they should be aware of the risks associated with lower liquidity and higher volatility in pre-market and post-market trading.',
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

SingleChildScrollView priceToBookHelp(BuildContext context) {
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
          helpText('PRICE-TO-BOOK RATIO'),
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
                      text: 'What is Price-To-Book ratio?\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'The price-to-book (P/B) ratio is a valuation metric that compares a company\'s market value, as represented by its current stock price, to its book value, which is the value of its net assets (assets minus liabilities) on the company\'s balance sheet. This ratio provides insight into how the market perceives the value of a company relative to its tangible and intangible assets.\n\nA P/B ratio below 1.0 suggests that the stock may be undervalued, indicating that the market price of the stock is lower than the company\'s book value. This could be a potential buying opportunity, especially for value investors who believe the market may not fully recognize the company\'s true worth. A P/B ratio above 1.0 may indicate that the stock is overvalued, meaning the market is valuing the company higher than its net assets.\n\nTo take advantage of the P/B ratio, investors can compare a company\'s P/B ratio to those of other companies in the same industry to determine if the stock is fairly valued. However, it\'s important to consider other factors such as the company\'s growth potential and financial health alongside the P/B ratio to make well-rounded investment decisions.',
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

SingleChildScrollView forwardPEhelp(BuildContext context) {
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
          helpText('FORWARD P/E RATIO'),
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
                      text: 'What is Forward P/E ratio?\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'The forward P/E ratio, also known as the forward price-to-earnings ratio, is a valuation metric that compares a company\'s current stock price to its expected earnings per share (EPS) over the next financial period, typically the next 12 months. This metric uses estimated future earnings rather than historical earnings, providing a forward-looking assessment of a company\'s valuation.',
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
                      text: '\n\nWhat does Forward P/E ratio indicate?\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'The forward P/E ratio gives investors a sense of how a company\'s current stock price compares to its projected future earnings. A lower forward P/E ratio may suggest that the stock is undervalued relative to its future earnings potential, while a higher ratio might indicate that the stock is overvalued. This ratio helps investors understand the market\'s expectations for a company\'s future performance.',
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
                      text:
                          'Investors can use the forward P/E ratio to gauge whether a stock may be a good investment based on its future earnings potential. A low forward P/E ratio might indicate an attractive buying opportunity, while a high ratio could signal caution. It\'s essential to consider other factors such as industry trends, market conditions, and the company\'s growth prospects alongside the forward P/E ratio to make well-rounded investment decisions.',
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

SingleChildScrollView pegHelp(BuildContext context) {
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
          helpText('PRICE-TO-EARNINGS GROWTH (PEG) RATIO'),
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
                      text: 'What is PEG ratio?\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'The PEG ratio, or price/earnings to growth ratio, is a valuation metric used to determine the relative trade-off between a stock\'s price, its earnings per share (EPS), and the company\'s expected growth rate. The ratio is calculated by dividing the stock\'s price-to-earnings (P/E) ratio by its expected earnings growth rate.',
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
                      text: '\n\nWhat does PEG ratio indicate?\n\n',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text:
                          'The PEG ratio provides insight into whether a stock is overvalued, undervalued, or fairly valued relative to its expected growth rate. A PEG ratio of 1.0 suggests that the stock is fairly valued, as the P/E ratio is in line with the expected growth rate. A PEG ratio below 1.0 may indicate that the stock is undervalued, while a ratio above 1.0 could suggest that the stock is overvalued.',
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
                      text:
                          'Investors can use the PEG ratio to assess potential investment opportunities. A ratio below 1.0 may signal a buying opportunity, while a ratio above 1.0 suggests the stock may be overvalued, prompting caution. It is important to consider other factors and metrics alongside the PEG ratio to make informed investment decisions.',
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
