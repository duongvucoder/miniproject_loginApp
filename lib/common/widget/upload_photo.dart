import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({Key? key}) : super(key: key);

  @override
  State<UploadPhoto> createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  final picker = ImagePicker();
  var url = '';
  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    return Container();
  }
}
