class ForgotSendOtpModel {
  final Message message;
  final Data data;

  ForgotSendOtpModel({
    required this.message,
    required this.data,
  });

  factory ForgotSendOtpModel.fromJson(Map<String, dynamic> json) => ForgotSendOtpModel(
    message: Message.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String token;

  Data({
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
  );
}

class Message {
  final List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    success: List<String>.from(json["success"].map((x) => x)),
  );
}