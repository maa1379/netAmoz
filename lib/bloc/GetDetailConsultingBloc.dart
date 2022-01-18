


import 'dart:async';
import 'package:ehyasalamat/models/GetDetailTicketModel.dart';

class GetDetailTicketBloc {
  final streamController = StreamController.broadcast();

  Stream get getStream => streamController.stream;

  GetDetailTicketModel data;

  void getProfile(GetDetailTicketModel item) {
    data = item;
    streamController.sink.add(this.data);
  }
}

final GetDetailTicketBloc getDetailTicketBlocInstance = new GetDetailTicketBloc();
