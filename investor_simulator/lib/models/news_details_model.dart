// To parse this JSON data, do
//
//     final newsDetailsModel = newsDetailsModelFromJson(jsonString);

import 'dart:convert';

NewsDetailsModel newsDetailsModelFromJson(String str) =>
    NewsDetailsModel.fromJson(json.decode(str));

String newsDetailsModelToJson(NewsDetailsModel data) =>
    json.encode(data.toJson());

class NewsDetailsModel {
  // int count;
  List<NewsDetails> news;

  NewsDetailsModel({
    // required this.count,
    required this.news,
  });

  factory NewsDetailsModel.fromJson(Map<String, dynamic> json) =>
      NewsDetailsModel(
        // count: json["count"],
        news: List<NewsDetails>.from(
            json["news"].map((x) => NewsDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "count": count,
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
      };
}

class NewsDetails {
  String title;
  String topImage;
  // List<String> images;
  // List<dynamic> videos;
  String url;
  // String date;
  // String shortDescription;
  String text;
  // Publisher publisher;

  NewsDetails({
    required this.title,
    required this.topImage,
    // required this.images,
    // required this.videos,
    required this.url,
    // required this.date,
    // required this.shortDescription,
    required this.text,
    // required this.publisher,
  });

  factory NewsDetails.fromJson(Map<String, dynamic> json) => NewsDetails(
        title: json["title"]?.toString() ?? '',
        topImage: json["top_image"]?.toString() ?? '',
        // images: List<String>.from(json["images"].map((x) => x)),
        // videos: List<dynamic>.from(json["videos"].map((x) => x)),
        url: json["url"]?.toString() ?? '',
        // date: json["date"],
        // shortDescription: json["short_description"],
        text: json["text"]?.toString() ?? '',
        // publisher: Publisher.fromJson(json["publisher"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "top_image": topImage,
        // "images": List<dynamic>.from(images.map((x) => x)),
        // "videos": List<dynamic>.from(videos.map((x) => x)),
        "url": url,
        // "date": date,
        // "short_description": shortDescription,
        "text": text,
        // "publisher": publisher.toJson(),
      };
}
