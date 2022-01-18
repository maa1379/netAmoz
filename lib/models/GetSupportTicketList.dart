

class GetSupportTicketList{
  GetSupportTicketList({
    this.id,
    this.topic,
    this.section,
    this.requestText,
    this.statusForUser,
    this.statusForSupport,
    this.userSeen,
    this.createdAt,
    this.answers,
  });

  int id;
  String topic;
  String section;
  String requestText;
  String statusForUser;
  String statusForSupport;
  bool userSeen;
  String createdAt;
  List<AnswerListSupport> answers;

  factory GetSupportTicketList.fromJson(Map<String, dynamic> json) => GetSupportTicketList(
    id: json["id"],
    topic: json["topic"],
    section: json["section"],
    requestText: json["request_text"],
    statusForUser: json["status_for_user"],
    statusForSupport: json["status_for_support"],
    userSeen: json["user_seen"],
    createdAt: json["created_at"],
    answers: List<AnswerListSupport>.from(json["answers"].map((x) => AnswerListSupport.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "topic": topic,
    "section": section,
    "request_text": requestText,
    "status_for_user": statusForUser,
    "status_for_support": statusForSupport,
    "user_seen": userSeen,
    "created_at": createdAt,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}

class AnswerListSupport {
  AnswerListSupport({
    this.user,
    this.ticket,
    this.text,
    this.status,
    this.createdAt,
  });

  String user;
  int ticket;
  String text;
  String status;
  String createdAt;

  factory AnswerListSupport.fromJson(Map<String, dynamic> json) => AnswerListSupport(
    user: json["user"],
    ticket: json["ticket"],
    text: json["text"],
    status: json["status"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "ticket": ticket,
    "text": text,
    "status": status,
    "created_at": createdAt,
  };
}
