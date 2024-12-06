class MyRecipientModel {
  final Data data;

  MyRecipientModel({
    required this.data,
  });

  factory MyRecipientModel.fromJson(Map<String, dynamic> json) => MyRecipientModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<Receipient> receipients;

  Data({
    required this.receipients,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    receipients: List<Receipient>.from(json["receipients"].map((x) => Receipient.fromJson(x))),
  );
}

class Receipient {
  final int id;
  final int userId;
  final String firstname;
  final String lastname;
  final String username;
  final dynamic type;
  final String email;
  final String address;
  final String country;
  final String state;
  final String city;
  final String zipCode;
  final String image;
  final String pathLocation;
  final String defaultImage;
  final DateTime createdAt;

  Receipient({
    required this.id,
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.type,
    required this.email,
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.zipCode,
    required this.image,
    required this.pathLocation,
    required this.defaultImage,
    required this.createdAt,
  });

  factory Receipient.fromJson(Map<String, dynamic> json) => Receipient(
    id: json["id"],
    userId: json["receipient_id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    username: json["username "],
    type: json["type "] ?? "",
    email: json["email"],
    address: json["address"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    zipCode: json["zip_code"],
    image: json["image"] ?? "",
    pathLocation: json["path_location"],
    defaultImage: json["default_image"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}