// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  Data data;

  NewsModel({
    required this.data,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Main main;

  Data({
    required this.main,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        main: Main.fromJson(json["main"]),
      );

  Map<String, dynamic> toJson() => {
        "main": main.toJson(),
      };
}

class Main {
  List<Stream> stream;

  Main({
    required this.stream,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        stream:
            List<Stream>.from(json["stream"].map((x) => Stream.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stream": List<dynamic>.from(stream.map((x) => x.toJson())),
      };
}

class Stream {
  String? id;
  Content content;

  Stream({
    required this.id,
    required this.content,
  });

  factory Stream.fromJson(Map<String, dynamic> json) => Stream(
        id: json["id"]?.toString() ?? '',
        content: Content.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content.toJson(),
      };
}

class Content {
  String id;

  String title;

  ClickThroughUrl? clickThroughUrl;

  DateTime pubDate;

  Thumbnail? thumbnail;

  Content({
    required this.id,
    required this.title,
    required this.clickThroughUrl,
    required this.pubDate,
    required this.thumbnail,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"]?.toString() ?? '',
        title: json["title"]?.toString() ?? '',
        clickThroughUrl: json["clickThroughUrl"] == null
            ? null
            : ClickThroughUrl.fromJson(json["clickThroughUrl"]),
        pubDate: DateTime.parse(json["pubDate"]),
        thumbnail: json["thumbnail"] == null
            ? null
            : Thumbnail.fromJson(json["thumbnail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "clickThroughUrl": clickThroughUrl?.toJson(),
        "pubDate": pubDate.toIso8601String(),
        "thumbnail": thumbnail?.toJson(),
      };
}

class ClickThroughUrl {
  String url;

  ClickThroughUrl({
    required this.url,
  });

  factory ClickThroughUrl.fromJson(Map<String, dynamic> json) =>
      ClickThroughUrl(
        url: json["url"]?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Thumbnail {
  List<Resolution> resolutions;

  Thumbnail({
    required this.resolutions,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        resolutions: List<Resolution>.from(
            json["resolutions"].map((x) => Resolution.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resolutions": List<dynamic>.from(resolutions.map((x) => x.toJson())),
      };
}

class Resolution {
  String url;
  int width;
  int height;

  Resolution({
    required this.url,
    required this.width,
    required this.height,
  });

  factory Resolution.fromJson(Map<String, dynamic> json) => Resolution(
        url: json["url"]?.toString() ?? '',
        width: json["width"]?.toInt() ?? 0,
        height: json["height"]?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}
