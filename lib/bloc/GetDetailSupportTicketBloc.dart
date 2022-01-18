
import 'dart:async';

import 'package:ehyasalamat/models/GetSupportChat.dart';


class GetSupportTicket {
  final streamController = StreamController.broadcast();

  Stream get getStream => streamController.stream;

  GetSupportChat data;

  void getSupportTicket(GetSupportChat item) {
    data = item;
    streamController.sink.add(this.data);
  }
}

final GetSupportTicket getDetailSupportTicketBlocInstance = new GetSupportTicket();