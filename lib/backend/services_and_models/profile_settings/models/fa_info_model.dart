class FaInfoModel {
  final Data data;

  FaInfoModel({
    required this.data,
  });

  factory FaInfoModel.fromJson(Map<String, dynamic> json) => FaInfoModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String qrCode;
  final String qrSecrete;
  final int status;
  final String message;

  Data({
    required this.qrCode,
    required this.qrSecrete,
    required this.status,
    required this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    qrCode: json["qr_code"],
    qrSecrete: json["qr_secrete"].toString(),
    status: json["status"],
    message: json["message"],
  );
}