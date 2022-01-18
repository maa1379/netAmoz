

class InformsModel {
  InformsModel({
    this.infType,
    this.topic,
    this.text,
    this.classification,
    this.createdAt,
  });

  String infType;
  String topic;
  String text;
  String classification;
  String createdAt;

  factory InformsModel.fromJson(Map<String, dynamic> json) => InformsModel(
    infType: json["inf_type"],
    topic: json["topic"],
    text: json["text"],
    classification: json["classification"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "inf_type": infType,
    "topic": topic,
    "text": text,
    "classification": classification,
    "created_at": createdAt,
  };
}