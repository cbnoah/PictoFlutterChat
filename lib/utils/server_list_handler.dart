import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:picto_flutter_chat/models/server_model.dart';

import 'auth_service.dart';

class ServerListHandler {
  late final Dio dio;
  late final String _apiAddress;

  static final ServerListHandler _instance = ServerListHandler._internal();

  factory ServerListHandler() {
    return _instance;
  }

  ServerListHandler._internal() {
    dio = Dio();
    _apiAddress = const String.fromEnvironment('API_URL');
  }

  Future<List<ServerModel>> getServerList() async {
    try {
      final token = await authService.value.currentUser?.getIdToken();
      final response = await dio.get(
        "$_apiAddress/api/servers",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      
      final servers = <ServerModel>[];
      
      for (final item in response.data) {
       if (item is! Map<String, dynamic>) continue;
       try {
         servers.add(ServerModel.fromJson(item));
       } on FormatException catch (e) {
         if (kDebugMode) {
           print("Object is not a valid ServerModel: $e");
         }
       }
      }
      
      return servers;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching server list: $e");
      }
      rethrow;
    }
  }
}
