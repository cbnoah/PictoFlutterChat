class ServerModel {
  late String id;
  late String ipAddress;
  late String name;
  late bool online;

  ServerModel({required this.id, required this.ipAddress, required this.name, required this.online});

  ServerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ipAddress = json['ipAddress'];
    name = json['name'];
    online = json['online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ipAddress'] = ipAddress;
    data['name'] = name;
    data['online'] = online;
    return data;
  }
}
