class RequestMoneyInfoModel {
  Data data;
  String type;

  RequestMoneyInfoModel({
    required this.data,
    required this.type,
  });

  factory RequestMoneyInfoModel.fromJson(Map<String, dynamic> json) => RequestMoneyInfoModel(
    data: Data.fromJson(json["data"]),
    type: json["type"],
  );
}

class Data {
  RequestMoneyInfo requestMoneyInfo;
  String baseUrl;

  Data({
    required this.requestMoneyInfo,
    required this.baseUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    requestMoneyInfo: RequestMoneyInfo.fromJson(json["request_money_info"]),
    baseUrl: json["base_url"],
  );
}

class RequestMoneyInfo {
  String token;
  String receiverEmail;
  double requestAmount;
  String requestCurrency;
  double exchangeRate;
  double totalCharge;
  double totalPayable;
  String remark;
  int status;

  RequestMoneyInfo({
    required this.token,
    required this.receiverEmail,
    required this.requestAmount,
    required this.requestCurrency,
    required this.exchangeRate,
    required this.totalCharge,
    required this.totalPayable,
    required this.remark,
    required this.status,
  });

  factory RequestMoneyInfo.fromJson(Map<String, dynamic> json) => RequestMoneyInfo(
    token: json["token"],
    receiverEmail: json["receiver_email"],
    requestAmount: json["request_amount"].toDouble(),
    requestCurrency: json["request_currency"],
    exchangeRate: json["exchange_rate"].toDouble(),
    totalCharge: json["total_charge"].toDouble(),
    totalPayable: json["total_payable"].toDouble(),
    remark: json["remark"] ?? "",
    status: json["status"],
  );
}