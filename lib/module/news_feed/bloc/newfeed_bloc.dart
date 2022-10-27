import 'dart:async';
import 'package:flutter/material.dart';
import 'package:miniproject/common/widget/progress_dialog.dart';
import 'package:miniproject/models/newfeed.dart';
import 'package:miniproject/services/api_service.dart';
import 'package:miniproject/services/newfeed_service.dart';

class NewfeedBloc {
  final _newfeedStremController = StreamController<List<NewFeed>>();
  Stream<List<NewFeed>> get streamNewfeed => _newfeedStremController.stream;

  final BuildContext context;

  final newfeeds = <NewFeed>[];
  NewfeedBloc(this.context) {
    getNewfeeds();
  }

  Future<void> getNewfeeds({bool isClear = false}) async {
    final progressDialog = ProgressDialog(context);
    progressDialog.show();
    await Future.delayed(const Duration(seconds: 3));
    await apiService
        .getNewfeeds(offset: isClear ? 0 : newfeeds.length)
        .then((value) {
      if (isClear) {
        newfeeds.clear();
      }
      if (value.isNotEmpty) {
        newfeeds.addAll(value);
        _newfeedStremController.add(newfeeds);
      } else if (isClear) {
        _newfeedStremController.add(newfeeds);
      }

      progressDialog.hide();
    }).catchError((e) {
      progressDialog.hide();

      _newfeedStremController.addError(e.toString());
    });
  }
}
