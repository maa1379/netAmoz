
class GetSupportChat {
  GetSupportChat({
    this.id,
    this.topic,
    this.section,
    this.requestText,
    this.status,
    this.createdAt,
    this.answers,
  });

  int id;
  String topic;
  String section;
  String requestText;
  String status;
  String createdAt;
  List<Answer> answers;

  factory GetSupportChat.fromJson(Map<String, dynamic> json) => GetSupportChat(
    id: json["id"],
    topic: json["topic"],
    section: json["section"],
    requestText: json["request_text"],
    status: json["status"],
    createdAt: json["created_at"],
    answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "topic": topic,
    "section": section,
    "request_text": requestText,
    "status": status,
    "created_at": createdAt,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}

class Answer {
  Answer({
    this.user,
    this.ticket,
    this.text,
    this.createdAt,
  });

  String user;
  int ticket;
  String text;
  String createdAt;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    user: json["user"],
    ticket: json["ticket"],
    text: json["text"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "ticket": ticket,
    "text": text,
    "created_at": createdAt,
  };
}
