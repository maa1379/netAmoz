import 'package:get/get.dart';




class SinglePostModel {
  SinglePostModel({
    this.id,
    this.title,
    this.category,
    this.image,
    this.file,
    this.shareLink,
    this.liked,
    this.shortDescription,
    this.tags,
    this.linkTv,
    this.radioEhya,
    this.ehyaTv,
    this.specialPost,
    this.published,
    this.comments,
    this.datePublished,
  });

  int id;
  String title;
  String category;
  String image;
  String file;
  String shareLink;
  bool liked;
  String shortDescription;
  List<Tag> tags;
  String linkTv;
  bool radioEhya;
  bool ehyaTv;
  bool specialPost;
  bool published;
  List<Comment> comments;
  String datePublished;

  factory SinglePostModel.fromJson(Map<String, dynamic> json) => SinglePostModel(
    id: json["id"],
    title: json["title"],
    category: json["category"],
    image: json["image"],
    file: json["file"],
    shareLink: json["share_link"],
    liked: json["liked"],
    shortDescription: json["short_description"],
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    linkTv: json["link_tv"],
    radioEhya: json["radio_ehya"],
    ehyaTv: json["ehya_tv"],
    specialPost: json["special_post"],
    published: json["published"],
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
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
    "short_description": shortDescription,
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "link_tv": linkTv,
    "radio_ehya": radioEhya,
    "ehya_tv": ehyaTv,
    "special_post": specialPost,
    "published": published,
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    "date_published": datePublished,
  };
}

class Comment {
  RxBool showComments = false.obs;

  Comment({
    this.id,
    this.user,
    this.text,
    this.dateCreated,
    this.children,
  });

  int id;
  String user;
  String text;
  String dateCreated;
  RxList<Comment> children;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    user: json["user"],
    text: json["text"],
    dateCreated: json["date_created"],
    children: RxList<Comment>.from(
        json["children"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "text": text,
    "date_created": dateCreated,
    "children": RxList<dynamic>.from(children.map((x) => x.toJson())),
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
