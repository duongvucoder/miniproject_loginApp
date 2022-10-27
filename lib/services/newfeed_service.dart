import 'package:miniproject/models/newfeed.dart';
import 'package:miniproject/services/api_service.dart';

extension NewFeedService on APIService {
  Future<List<NewFeed>> getNewfeeds({
    int limit = 20,
    required int offset,
  }) async {
    final result = await request(
      path: '/api/issues?limit=$limit&offset=$offset',
      method: Method.get,
    );
    final newfeeds = List<NewFeed>.from(result.map((e) => NewFeed.fromJson(e)));
    return newfeeds;
  }

  Future<List<AccountPublic>> accoutPublic({
    int limit = 20,
    required int offset,
  }) async {
    final result = await request(
      path: '/api/issues?limit=$limit&offset=$offset',
      method: Method.get,
    );
    final account =
        List<AccountPublic>.from(result.map((e) => AccountPublic.fromJson(e)));
    return account;
  }
}
