class RequestMoneyLogModel {
  final Data data;

  RequestMoneyLogModel({
    required this.data,
  });

  factory RequestMoneyLogModel.fromJson(Map<String, dynamic> json) => RequestMoneyLogModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final Transactions transactions;

  Data({
    required this.transactions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    transactions: Transactions.fromJson(json["transactions"]),
  );
}

class Transactions {
  final List<Datum> data;
  final int lastPage;

  Transactions({
    required this.data,
    required this.lastPage,
  });

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    lastPage: json["last_page"],
  );
}

class Datum {
  final int id;
  final String identifier;
  final String createdBy;
  final String paidBy;
  final double requestAmount;
  final String requestCurrency;
  final double exchangeRate;
  // final double percentCharge;
  // final double fixedCharge;
  final double totalCharge;
  final double totalPayable;
  final String link;
  final dynamic remark;
  final int status;
  final DateTime createdAt;
  // final DateTime updatedAt;

  Datum({
    required this.id,
    required this.identifier,
    required this.createdBy,
    required this.paidBy,
    required this.requestAmount,
    required this.requestCurrency,
    required this.exchangeRate,
    // required this.percentCharge,
    // required this.fixedCharge,
    required this.totalCharge,
    required this.totalPayable,
    required this.link,
    required this.remark,
    required this.status,
    required this.createdAt,
    // required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    identifier: json["identifier"],
    createdBy: json["created_by"] ?? "",
    paidBy: json["paid_by"] ?? "",
    requestAmount: json["request_amount"].toDouble(),
    requestCurrency: json["request_currency"],
    exchangeRate: json["exchange_rate"].toDouble(),
    // percentCharge: json["percent_charge"].toDouble(),
    // fixedCharge: json["fixed_charge"].toDouble(),
    totalCharge: json["total_charge"].toDouble(),
    totalPayable: json["total_payable"].toDouble(),
    link: json["link"],
    remark: json["remark"] ?? "",
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
  );
}