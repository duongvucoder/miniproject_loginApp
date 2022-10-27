import 'dart:async';
import 'package:flutter/material.dart';
import 'package:miniproject/models/profile.dart';
import 'package:miniproject/services/api_service.dart';
import 'package:miniproject/services/profile_service.dart';

class ProfileBloc {
  final _profileStremController = StreamController<Profile>();
  Stream<Profile> get streamProfile => _profileStremController.stream;
  final BuildContext context;
  final profile = Profile();
  ProfileBloc(this.context) {
    getProfile();
  }

  void getProfile() {
    apiService.getprofile().then((value) {
      _profileStremController.add(value);
    }).catchError((e) {
      _profileStremController.addError(e.toString());
    });
  }
}
