

class GetTicketModel {
  GetTicketModel({
    this.id,
    this.topic,
    this.section,
    this.requestText,
    this.file,
    this.statusForUser,
    this.statusForExpert,
    this.userSeen,
    this.createdAt,
    this.answers,
  });

  int id;
  String topic;
  String section;
  String requestText;
  String file;
  String statusForUser;
  String statusForExpert;
  bool userSeen;
  String createdAt;
  List<Answer> answers;

  factory GetTicketModel.fromJson(Map<String, dynamic> json) => GetTicketModel(
    id: json["id"],
    topic: json["topic"],
    section: json["section"],
    requestText: json["request_text"],
    file: json["file"],
    statusForUser: json["status_for_user"],
    statusForExpert: json["status_for_expert"],
    userSeen: json["user_seen"],
    createdAt: json["created_at"],
    answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "topic": topic,
    "section": section,
    "request_text": requestText,
    "file": file,
    "status_for_user": statusForUser,
    "status_for_expert": statusForExpert,
    "user_seen": userSeen,
    "created_at": createdAt,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}

class Answer {
  Answer({
    this.user,
    this.text,
    this.status,
    this.file,
    this.createdAt,
  });

  String user;
  String text;
  String status;
  String file;
  String createdAt;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    user: json["user"],
    text: json["text"],
    status: json["status"],
    file: json["file"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "text": text,
    "status": status,
    "file": file,
    "created_at": createdAt,
  };
}
