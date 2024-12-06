class LogModel {
  final Data data;

  LogModel({
    required this.data,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) => LogModel(
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
  final int status;
  final String type;
  final dynamic attribute;
  final String trxId;
  final String gatewayCurrency;
  final String transactionType;
  final double requestAmount;
  final String requestCurrency;
  final double exchangeRate;
  final double totalCharge;
  final double totalPayable;
  final double receiveAmount;
  final String paymentCurrency;
  final String remark;
  final String receiverUsername;
  final DateTime createdAt;

  Datum({
    required this.id,
    required this.status,
    required this.type,
    required this.attribute,
    required this.trxId,
    required this.gatewayCurrency,
    required this.transactionType,
    required this.requestAmount,
    required this.requestCurrency,
    required this.exchangeRate,
    required this.totalCharge,
    required this.totalPayable,
    required this.receiveAmount,
    required this.paymentCurrency,
    required this.remark,
    required this.createdAt,
    required this.receiverUsername,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    status: json["status"],
    type: json["type"],
    attribute: json["attribute"] ?? "",
    trxId: json["trx_id"],
    gatewayCurrency: json["gateway_currency"] ?? "",
    transactionType: json["transaction_type"],
    requestAmount: json["request_amount"].toDouble(),
    requestCurrency: json["request_currency"],
    exchangeRate: json["exchange_rate"].toDouble(),
    totalCharge: json["total_charge"].toDouble(),
    totalPayable: json["total_payable"].toDouble(),
    receiveAmount: json["receive_amount"].toDouble(),
    paymentCurrency: json["payment_currency"],
    remark: json["remark"] ?? "",
    receiverUsername: json["receiver_username"] ?? "",
    createdAt: DateTime.parse(json["created_at"]),
  );
}