

class SectionModel {
  SectionModel({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}