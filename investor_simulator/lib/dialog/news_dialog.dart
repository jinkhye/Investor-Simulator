import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/models/news_details_model.dart';
import 'package:investor_simulator/provider/news_provider.dart';
import 'package:investor_simulator/pages/news_assessment.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

void openNewsDialog(BuildContext context, String newsURL, String pubDate) {
  final provider = Provider.of<NewsProvider>(context, listen: false);
  provider.emptyNewsDetails();
  provider.fetchDetails(newsURL);

  // Show the custom dialog with a general dialog
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
          child: Stack(
            children: [
              // Dialog for displaying news content
              Positioned(
                bottom: 100,
                child: Column(
                  children: [
                    Dialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Consumer<NewsProvider>(
                          builder: (context, provider, child) {
                            if (provider.newsDetails.isNotEmpty) {
                              return newsPage(
                                  context, provider.newsDetails[0], pubDate);
                            } else if (provider.isLoadingDetails) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (provider.hasErrorDetails) {
                              return Center(
                                child: Text(provider.errorMessage),
                              );
                            } else {
                              return const Center(
                                  child: Text('Loading news details...'));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Position aiAssessment outside of the dialog
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Consumer<NewsProvider>(
                  builder: (context, provider, child) {
                    if (provider.newsDetails.isNotEmpty) {
                      return aiAssessment(context, provider.newsDetails[0]);
                    } else {
                      return Container(); // Return empty container if data not available yet
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

SingleChildScrollView newsPage(
    BuildContext context, NewsDetails content, String pubDate) {
  String title = content.title;
  String imageURL = content.topImage;
  String text = content.text;

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
              Positioned(top: 0, left: 0, child: webBrowser(content.url)),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 400,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(imageURL),
                fit: BoxFit.cover,
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
              title,
              style: const TextStyle(
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: darkPurple,
                overflow: TextOverflow.clip,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 295,
            child: Text(
              pubDate,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(
            height: 15,
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
                text,
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
        ],
      ),
    ),
  );
}

Widget webBrowser(String url) {
  return SizedBox(
    width: 50,
    height: 40,
    child: TextButton(
      onPressed: () async {
        try {
          final Uri uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            print('Could not open $url');
          }
        } on Exception catch (e) {
          print('Error launching URL: $e');
        }
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        side: const BorderSide(color: darkPurple, width: 2),
        backgroundColor: white,
        elevation: 0,
      ),
      child: const Icon(Icons.public),
    ),
  );
}

ElevatedButton aiAssessment(
  BuildContext context,
  NewsDetails content,
) {
  return ElevatedButton(
    onPressed: () {
      Get.to(
          () => NewsAssessment(
                news: content,
              ),
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
          width: 5,
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
