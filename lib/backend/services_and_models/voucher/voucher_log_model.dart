class VoucherLogModel {
  final Data data;

  VoucherLogModel({
    required this.data,
  });

  factory VoucherLogModel.fromJson(Map<String, dynamic> json) => VoucherLogModel(
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
  final String code;
  // final int userId;
  final double requestAmount;
  final String requestCurrency;
  final double exchangeRate;
  // final double percentCharge;
  // final double fixedCharge;
  final double totalCharge;
  final double totalPayable;
  final int status;
  final DateTime createdAt;

  Datum({
    required this.id,
    required this.code,
    // required this.userId,
    required this.requestAmount,
    required this.requestCurrency,
    required this.exchangeRate,
    // required this.percentCharge,
    // required this.fixedCharge,
    required this.totalCharge,
    required this.totalPayable,
    required this.status,
    required this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    code: json["code"],
    // userId: json["user_id"],
    requestAmount: json["request_amount"].toDouble(),
    requestCurrency: json["request_currency"],
    exchangeRate: json["exchange_rate"].toDouble(),
    // percentCharge: json["percent_charge"].toDouble(),
    // fixedCharge: json["fixed_charge"].toDouble(),
    totalCharge: json["total_charge"].toDouble(),
    totalPayable: json["total_payable"].toDouble(),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}