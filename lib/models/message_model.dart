enum MessageType {
  text,
  image
}

class MessageModel {
  late String content;
  late DateTime createdAt;
  late String id;
  late MessageType messageType;
  late String serverId;
  late String userId;
  late String username;

  MessageModel({required this.content,
    required this.createdAt,
    required this.id,
    required this.messageType,
    required this.serverId,
    required this.userId,
    required this.username});

  MessageModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    createdAt = DateTime.parse(json['createdAt']);
    id = json['id'];
    messageType = stringToMessageType(json['messageType']);
    serverId = json['serverId'];
    userId = json['userId'];
    username = json['user']['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['createdAt'] = createdAt;
    data['id'] = id;
    data['messageType'] = messageTypeToString(messageType);
    data['serverId'] = serverId;
    data['userId'] = userId;
    return data;
  }

  static MessageType stringToMessageType(String messageType) {
    switch (messageType) {
      case "text":
        return MessageType.text;
      case "image":
        return MessageType.image;
      default:
        return MessageType.text;
    }
  }

  static String messageTypeToString(MessageType messageType) {
    switch (messageType) {
      case MessageType.text:
        return "text";
      case MessageType.image:
        return "image";
    }
  }
}