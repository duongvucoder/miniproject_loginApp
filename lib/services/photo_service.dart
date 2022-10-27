import 'package:image_picker/image_picker.dart';
import 'package:miniproject/models/photo.dart';
import 'package:miniproject/services/api_service.dart';

extension PhotoService on APIService {
  Future<Photo> uploadAvatar({required XFile file}) async {
    Map<String, dynamic> result =
        await request(path: '/api/upload', file: file);
    final photo = Photo.fromJson(result);
    return photo;
  }
}
