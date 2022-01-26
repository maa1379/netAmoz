
class CategoriesModel {
  CategoriesModel({
    this.id,
    this.name,
    this.children,
  });

  int id;
  String name;
  List<CategoriesModel> children;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    id: json["id"],
    name: json["name"],
    children: List<CategoriesModel>.from(json["children"].map((x) => CategoriesModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "children": List<dynamic>.from(children.map((x) => x.toJson())),
  };
}
