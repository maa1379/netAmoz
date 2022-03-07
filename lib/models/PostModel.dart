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

class Result {
  Result({
    this.id,
    this.title,
    this.category,
    this.image,
    this.file,
    this.shareLink,
    this.liked,
    this.likesCount,
    this.shortDescription,
    this.tags,
    this.linkTv,
    this.radioEhya,
    this.specialPost,
    this.ehyaTv,
    this.published,
    this.datePublished,
  });

  int id;
  String title;
  String category;
  String image;
  String file;
  String shareLink;
  bool liked;
  int likesCount;
  String shortDescription;
  List<Tag> tags;
  String linkTv;
  bool radioEhya;
  bool specialPost;
  bool ehyaTv;
  bool published;
  String datePublished;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
    category: json["category"],
    image: json["image"],
    file: json["file"],
    shareLink: json["share_link"],
    liked: json["liked"],
    likesCount: json["likes_count"],
    shortDescription: json["short_description"],
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    linkTv: json["link_tv"],
    radioEhya: json["radio_ehya"],
    specialPost: json["special_post"],
    ehyaTv: json["ehya_tv"],
    published: json["published"],
    datePublished: json["date_published"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "category": category,
    "image": image,
    "file": file,
    "share_link": shareLink,
    "liked": liked,
    "likes_count": likesCount,
    "short_description": shortDescription,
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "link_tv": linkTv,
    "radio_ehya": radioEhya,
    "special_post": specialPost,
    "ehya_tv": ehyaTv,
    "published": published,
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
