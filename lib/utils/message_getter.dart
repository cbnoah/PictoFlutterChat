import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:picto_flutter_chat/models/message_model.dart';
import 'package:picto_flutter_chat/utils/auth_service.dart';

class MessageGetter {
  late final Dio dio;
  late final String _apiAddress;

  static final MessageGetter _instance = MessageGetter._internal();

  factory MessageGetter() {
    return _instance;
  }

  MessageGetter._internal() {
    dio = Dio();
    _apiAddress = const String.fromEnvironment('API_URL');
  }

  Future<List<MessageModel>> getMessages(String serverId) async {
    try {
      final token = await authService.value.currentUser?.getIdToken();
      final response = await dio.get(
        '$_apiAddress/api/messages/$serverId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return (response.data["messages"] as List)
          .map((e) => MessageModel.fromJson(e))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching messages: $e');
      }
      rethrow;
    }
  }
}
