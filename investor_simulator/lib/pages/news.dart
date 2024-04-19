import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/dialog/news_dialog.dart';

import 'package:investor_simulator/menu/topMenu.dart';
import 'package:investor_simulator/models/news_model.dart' as n;
import 'package:investor_simulator/provider/news_provider.dart';
import 'package:provider/provider.dart';

import 'package:stroke_text/stroke_text.dart';

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
                child: _buildStocksMenu(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStocksMenu(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: [
            Center(child: stocksText()),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Consumer<NewsProvider>(
            builder: (context, provider, _) {
              if (provider.isLoadingNews) {
                return const Center(child: CircularProgressIndicator());
              } else if (provider.hasError) {
                return Center(child: Text('Error: ${provider.errorMessage}'));
              } else {
                return _stocksSection(context, provider.news);
              }
            },
          ),
        ),
      ],
    );
  }

  Column _stocksSection(BuildContext context, List<n.Stream> news) {
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
              final newsCurrent = news[index];
              n.Content content = newsCurrent.content;
              String title = content.title;
              DateTime pubDate = content.pubDate;
              DateFormat dateFormat = DateFormat('dd/MM/yyyy hh:mm a');
              List<n.Resolution>? resolutions = content.thumbnail?.resolutions;
              String url = resolutions?[0].url ??
                  'https://i.pinimg.com/736x/26/91/f2/2691f2fa1a0f078f5f274edf7fea6763.jpg';
              String newsURL = content.clickThroughUrl?.url ?? '';

              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    openNewsDialog(
                        context, newsURL, dateFormat.format(pubDate.toLocal()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Colors
                        .transparent, // Set the background color to transparent
                    elevation: 0, // Remove the elevation
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          Container(
                              alignment: Alignment.topRight,
                              height: 200,
                              width: 330,
                              decoration: BoxDecoration(
                                border: Border.all(color: white, width: 2),
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(url),
                                  fit: BoxFit.cover,
                                ),
                              )),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 330,
                            child: Text(
                              title,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: white,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 330,
                            child: Row(children: [
                              Text(
                                dateFormat.format(pubDate.toLocal()),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey[350],
                                    fontStyle: FontStyle.italic),
                              ),
                              Expanded(child: Container()),
                              Text(
                                timeAgo(pubDate),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey[350],
                                    fontStyle: FontStyle.italic),
                              ),
                            ]),
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 2,
                            indent: 15,
                            endIndent: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String timeAgo(DateTime dateTime) {
    // Calculate the difference between the current time and the provided dateTime
    Duration difference = DateTime.now().difference(dateTime);

    // Determine the time unit (seconds, minutes, hours, or days) and format the output
    if (difference.inSeconds < 60) {
      // Less than a minute ago, return "Just Now"
      return 'Just Now';
    } else if (difference.inMinutes < 60) {
      // Less than an hour ago
      int minutes = difference.inMinutes;
      String unit = minutes == 1 ? 'minute' : 'minutes';
      return '$minutes $unit ago';
    } else if (difference.inHours < 24) {
      // Less than a day ago
      int hours = difference.inHours;
      String unit = hours == 1 ? 'hour' : 'hours';
      return '$hours $unit ago';
    } else {
      // More than a day ago
      int days = difference.inDays;
      String unit = days == 1 ? 'day' : 'days';
      return '$days $unit ago';
    }
  }

  StrokeText stocksText() {
    return const StrokeText(
      text: "TRENDING NEWS",
      textStyle: TextStyle(fontSize: 40, color: yellow),
      strokeColor: darkPurple,
      strokeWidth: 7,
    );
  }
}
