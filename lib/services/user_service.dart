import 'package:miniproject/models/user.dart';
import 'package:miniproject/services/api_service.dart';

extension UserService on APIService {
  Future<User> login({
    required String phone,
    required String password,
  }) async {
    final body = {'PhoneNumber': phone, 'Password': password};
    final result = await request(
      path: '/api/accounts/login',
      body: body,
      method: Method.post,
    );
    final user = User.fromJson(result);
    return user;
  }

  Future<User> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String andress,
  }) async {
    final body = {
      'PhoneNumber': phone,
      'Password': password,
      'Name': name,
      'Email': email,
      'Andress': andress,
    };
    final result = await request(
      path: '/api/accounts/register',
      body: body,
      method: Method.post,
    );
    final user = User.fromJson(result);
    return user;
  }
}
