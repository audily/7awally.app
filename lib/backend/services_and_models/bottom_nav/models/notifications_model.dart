class NotificationModel {
  final Data data;

  NotificationModel({
    required this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<Notification> notifications;

  Data({
    required this.notifications,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notifications: List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
  );
}

class Notification {
  // final int id;
  // final int userId;
  final String type;
  final Message message;
  // final int seen;
  final DateTime createdAt;
  final DateTime updatedAt;

  Notification({
    // required this.id,
    // required this.userId,
    required this.type,
    required this.message,
    // required this.seen,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    // id: json["id"],
    // userId: json["user_id"],
    type: json["type"],
    message: Message.fromJson(json["message"]),
    // seen: json["seen"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}

class Message {
  final String title;
  final String image;
  final String message;
  final String time;

  Message({
    required this.image,
    required this.title,
    required this.message,
    required this.time,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    title: json["title"],
    image: json["image"],
    message: json["message"],
    time: json["time"],
  );
}