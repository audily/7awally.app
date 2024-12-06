class MaintenanceModel {
  Message message;
  Data data;

  MaintenanceModel({
    required this.message,
    required this.data,
  });

  factory MaintenanceModel.fromJson(Map<String, dynamic> json) =>
      MaintenanceModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  String baseUrl;
  String imagePath;
  String image;
  bool status;
  String title;
  String details;

  Data({
    required this.baseUrl,
    required this.imagePath,
    required this.image,
    required this.status,
    required this.title,
    required this.details,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        baseUrl: json["base_url"],
        imagePath: json["image_path"],
        image: json["image"],
        status: json["status"],
        title: json["title"],
        details: json["details"],
      );
}

class Message {
  List<String> error;

  Message({
    required this.error,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        error: List<String>.from(json["error"].map((x) => x)),
      );
}
