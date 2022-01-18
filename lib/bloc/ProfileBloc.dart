import 'dart:async';
import 'package:ehyasalamat/models/ProfileModel.dart';

class GetProfileBloc {
  final streamController = StreamController.broadcast();

  Stream get getStream => streamController.stream;

  ProfileModel profile;

  void getProfile(ProfileModel item) {
    profile = item;
    streamController.sink.add(this.profile);
  }
}

final GetProfileBloc getProfileBlocInstance = new GetProfileBloc();
