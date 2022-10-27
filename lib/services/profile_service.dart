import 'package:miniproject/models/profile.dart';

import 'package:miniproject/services/api_service.dart';

extension ProfileService on APIService {
  Future<Profile> getprofile() async {
    final result = await request(
      path: '/api/accounts/profile',
      method: Method.get,
    );
    // ignore: avoid_print
    print('getProfile');
    final profile = Profile.fromJson(result);
    return profile;
  }
}
