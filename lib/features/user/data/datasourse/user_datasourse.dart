import 'package:injectable/injectable.dart';
import 'package:whoami_app/core/network/service/main/main_api_service.dart';

@injectable
class UserDatasourse {
  final MainApiService _apiService;

  UserDatasourse(this._apiService);

  Future<String> getUser() async {
    final response = await _apiService.getUserId();
    return response.userId;
  }
}
