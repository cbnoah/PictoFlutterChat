
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:picto_flutter_chat/utils/auth_service.dart';

class ApiUserSync {
  late final Dio dio;
  late final String _apiAddress;

  static final ApiUserSync _instance = ApiUserSync._internal();

  factory ApiUserSync() {
    return _instance;
  }

  ApiUserSync._internal() {
    dio = Dio();
    _apiAddress = const String.fromEnvironment('API_URL');
  }

  Future<dynamic> syncUsers() async {
    try {
      final token = await authService.value.currentUser?.getIdToken();
      final response = await dio.post(
        "$_apiAddress/api/users/sync",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "authorization": "Bearer $token",
          },
        ),
      );
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
