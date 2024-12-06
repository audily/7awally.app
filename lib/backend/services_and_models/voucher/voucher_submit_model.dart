class VoucherSubmitModel {
  final Message message;
  final Data data;

  VoucherSubmitModel({
    required this.message,
    required this.data,
  });

  factory VoucherSubmitModel.fromJson(Map<String, dynamic> json) => VoucherSubmitModel(
    message: Message.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String code;
  final double requestAmount;
  final String requestCurrency;
  final double exchangeRate;
  final double percentCharge;
  final double fixedCharge;
  final double totalCharge;
  final double totalPayable;

  Data({
    required this.code,
    required this.requestAmount,
    required this.requestCurrency,
    required this.exchangeRate,
    required this.percentCharge,
    required this.fixedCharge,
    required this.totalCharge,
    required this.totalPayable,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    code: json["code"],
    requestAmount: json["request_amount"].toDouble(),
    requestCurrency: json["request_currency"],
    exchangeRate: json["exchange_rate"].toDouble(),
    percentCharge: json["percent_charge"].toDouble(),
    fixedCharge: json["fixed_charge"].toDouble(),
    totalCharge: json["total_charge"].toDouble(),
    totalPayable: json["total_payable"].toDouble(),
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