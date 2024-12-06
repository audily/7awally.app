class RequestMoneySubmitModel {
  final Data data;

  RequestMoneySubmitModel({
    required this.data,
  });

  factory RequestMoneySubmitModel.fromJson(Map<String, dynamic> json) => RequestMoneySubmitModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final double requestAmount;
  final String requestCurrency;
  final double exchangeRate;
  final double percentCharge;
  final double fixedCharge;
  final double totalCharge;
  final double totalPayable;
  final String link;
  final String remark;
  final int status;

  Data({
    required this.requestAmount,
    required this.requestCurrency,
    required this.exchangeRate,
    required this.percentCharge,
    required this.fixedCharge,
    required this.totalCharge,
    required this.totalPayable,
    required this.link,
    required this.remark,
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    requestAmount: json["request_amount"].toDouble(),
    requestCurrency: json["request_currency"],
    exchangeRate: json["exchange_rate"].toDouble(),
    percentCharge: json["percent_charge"].toDouble(),
    fixedCharge: json["fixed_charge"].toDouble(),
    totalCharge: json["total_charge"].toDouble(),
    totalPayable: json["total_payable"].toDouble(),
    link: json["link"],
    remark: json["remark"] ?? "",
    status: json["status"],
  );
}