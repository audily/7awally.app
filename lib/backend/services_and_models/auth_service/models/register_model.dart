class RegisterModel {
  final Data data;

  RegisterModel({
    required this.data,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String token;
  final Authorization authorization;

  Data({
    required this.token,
    required this.authorization,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    authorization: Authorization.fromJson(json["authorization"]),
  );
}

class Authorization {
  final bool status;
  final String token;

  Authorization({
    required this.status,
    required this.token,
  });

  factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
    status: json["status"],
    token: json["token"] ?? "",
  );
}