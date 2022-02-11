// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  static List<PostModel> listFromJson(List data) {
    print(data);
    return List<PostModel>.from(data.map((x) => PostModel.fromJson(x)));
  }

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] is List
            ? List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

// To parse this JSON data, do
//
//     final result = resultFromJson(jsonString);


class Result {
  Result({
    this.id,
    this.title,
    this.category,
    this.image,
    this.file,
    this.shortDescription,
    this.tags,
    this.linkTv,
    this.radioEhya,
    this.ehyaTv,
    this.published,
    this.specialPost,
    this.datePublished,
  });

  int id;
  String title;
  String category;
  String image;
  String file;
  String shortDescription;
  List<Tag> tags;
  String linkTv;
  bool radioEhya;
  bool ehyaTv;
  bool published;
  bool specialPost;
  String datePublished;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
    category: json["category"],
    image: json["image"],
    file: json["file"],
    shortDescription: json["short_description"],
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    linkTv: json["link_tv"],
    radioEhya: json["radio_ehya"],
    ehyaTv: json["ehya_tv"],
    published: json["published"],
    specialPost: json["special_post"],
    datePublished: json["date_published"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "category": category,
    "image": image,
    "file": file,
    "short_description": shortDescription,
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "link_tv": linkTv,
    "radio_ehya": radioEhya,
    "ehya_tv": ehyaTv,
    "published": published,
    "special_post": specialPost,
    "date_published": datePublished,
  };
}


class Tag {
  Tag({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
