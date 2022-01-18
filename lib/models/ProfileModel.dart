class ProfileModel {
  ProfileModel({
    this.phoneNumber,
    this.role,
    this.firstName,
    this.lastName,
    this.province,
    this.city,
    this.birthday,
    this.gender,
    this.degree,
    this.fieldOfStudy,
    this.job,
    this.points,
    this.profileDone,
    this.hasPoints,
  });

  String phoneNumber;
  String role;
  String firstName;
  String lastName;
  String province;
  String city;
  String birthday;
  String gender;
  String degree;
  String fieldOfStudy;
  String job;
  int points;
  bool profileDone;
  bool hasPoints;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    phoneNumber: json["phone_number"],
    role: json["role"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    province: json["province"],
    city: json["city"],
    birthday: json["birthday"],
    gender: json["gender"],
    degree: json["degree"],
    fieldOfStudy: json["field_of_study"],
    job: json["job"],
    points: json["points"],
    profileDone: json["profile_done"],
    hasPoints: json["has_points"],
  );

  Map<String, dynamic> toJson() => {
    "phone_number": phoneNumber,
    "role": role,
    "first_name": firstName,
    "last_name": lastName,
    "province": province,
    "city": city,
    "birthday": birthday,
    "gender": gender,
    "degree": degree,
    "field_of_study": fieldOfStudy,
    "job": job,
    "points": points,
    "profile_done": profileDone,
    "has_points": hasPoints,
  };
}


