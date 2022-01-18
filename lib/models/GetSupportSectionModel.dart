

class GetSupportSectionModel {
  GetSupportSectionModel({
    this.id,
    this.name,
    this.associatedRoles,
    this.active,
  });

  int id;
  String name;
  List<String> associatedRoles;
  bool active;

  factory GetSupportSectionModel.fromJson(Map<String, dynamic> json) => GetSupportSectionModel(
    id: json["id"],
    name: json["name"],
    associatedRoles: List<String>.from(json["associated_roles"].map((x) => x)),
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "associated_roles": List<dynamic>.from(associatedRoles.map((x) => x)),
    "active": active,
  };
}