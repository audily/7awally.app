class SendMoneySubmitModel {
  final Data data;

  SendMoneySubmitModel({
    required this.data,
  });

  factory SendMoneySubmitModel.fromJson(Map<String, dynamic> json) => SendMoneySubmitModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String identifier;
  final ConfirmDetails confirmDetails;

  Data({
    required this.identifier,
    required this.confirmDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    identifier: json["identifier"],
    confirmDetails: ConfirmDetails.fromJson(json["confirm_details"]),
  );
}

class ConfirmDetails {
  final double senderAmount;
  final String senderCurrency;
  final double receiverAmount;
  final String receiverCurrency;
  final double exchangeRate;
  final double totalCharge;
  final double willGet;
  final double totalPayable;

  ConfirmDetails({
    required this.senderAmount,
    required this.senderCurrency,
    required this.receiverAmount,
    required this.receiverCurrency,
    required this.exchangeRate,
    required this.totalCharge,
    required this.willGet,
    required this.totalPayable,
  });

  factory ConfirmDetails.fromJson(Map<String, dynamic> json) => ConfirmDetails(
    senderAmount: json["sender_amount"].toDouble(),
    senderCurrency: json["sender_currency"],
    receiverAmount: json["receiver_amount"].toDouble(),
    receiverCurrency: json["receiver_currency"],
    exchangeRate: json["exchange_rate"].toDouble(),
    totalCharge: json["total_charge"].toDouble(),
    willGet: json["will_get"].toDouble(),
    totalPayable: json["total_payable"].toDouble(),
  );
}