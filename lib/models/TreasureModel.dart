


class TreasureModel {
  TreasureModel({
    this.id,
    this.user,
    this.topic,
    this.link,
    this.file,
    this.answer,
  });

  int id;
  String user;
  String topic;
  String link;
  String file;
  String answer;

  factory TreasureModel.fromJson(Map<String, dynamic> json) => TreasureModel(
    id: json["id"],
    user: json["user"],
    topic: json["topic"],
    link: json["link"],
    file: json["file"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "topic": topic,
    "link": link,
    "file": file,
    "answer": answer,
  };
}