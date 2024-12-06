import '../../../widgets/dropdown/custom_dropdown_widget.dart';

class AddMoneyIndexModel {
  final Data data;

  AddMoneyIndexModel({
    required this.data,
  });

  factory AddMoneyIndexModel.fromJson(Map<String, dynamic> json) => AddMoneyIndexModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final PaymentGateways paymentGateways;

  Data({
    required this.paymentGateways,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    paymentGateways: PaymentGateways.fromJson(json["payment_gateways"]),
  );
}

class PaymentGateways {
  final List<UserWallet> userWallet;
  final List<GatewayCurrency> gatewayCurrencies;

  PaymentGateways({
    required this.userWallet,
    required this.gatewayCurrencies,
  });

  factory PaymentGateways.fromJson(Map<String, dynamic> json) => PaymentGateways(
    userWallet: List<UserWallet>.from(json["user_wallet"].map((x) => UserWallet.fromJson(x))),
    gatewayCurrencies: List<GatewayCurrency>.from(json["gateway_currencies"].map((x) => GatewayCurrency.fromJson(x))),
  );
}

class GatewayCurrency {
  final int id;
  final String type;
  final String name;
  final bool crypto;
  final dynamic desc;
  final bool status;
  final List<Currency> currencies;

  GatewayCurrency({
    required this.id,
    required this.type,
    required this.name,
    required this.crypto,
    required this.desc,
    required this.status,
    required this.currencies,
  });

  factory GatewayCurrency.fromJson(Map<String, dynamic> json) => GatewayCurrency(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    crypto: json["crypto"],
    desc: json["desc"] ?? "",
    status: json["status"],
    currencies: List<Currency>.from(json["currencies"].map((x) => Currency.fromJson(x))),
  );
}

class Currency extends DropdownModel{
  final int id;
  final int paymentGatewayId;
  final String name;
  final String alias;
  final String currencyCode;
  final String currencySymbol;
  final dynamic image;
  final double minLimit;
  final double maxLimit;
  final double percentCharge;
  final double fixedCharge;
  final double rate;

  Currency({
    required this.id,
    required this.paymentGatewayId,
    required this.name,
    required this.alias,
    required this.currencyCode,
    required this.currencySymbol,
    required this.image,
    required this.minLimit,
    required this.maxLimit,
    required this.percentCharge,
    required this.fixedCharge,
    required this.rate
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    id: json["id"],
    paymentGatewayId: json["payment_gateway_id"],
    name: json["name"],
    alias: json["alias"],
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"] ?? "",
    image: json["image"] ?? "",
    minLimit: json["min_limit"].toDouble(),
    maxLimit: json["max_limit"].toDouble(),
    percentCharge: json["percent_charge"].toDouble(),
    fixedCharge: json["fixed_charge"].toDouble(),
    rate: json["rate"].toDouble()
  );

  @override
  // TODO: implement img
  String get img => throw UnimplementedError();

  @override
  // TODO: implement title
  String get title => name;
}

class UserWallet extends DropdownModel{
  final String name;
  final double balance;
  final String currencyCode;
  final String currencySymbol;
  final String currencyType;
  final double rate;
  final String flag;
  final String imagePath;

  UserWallet({
    required this.name,
    required this.balance,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyType,
    required this.rate,
    required this.flag,
    required this.imagePath,
  });

  factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
    name: json["name"],
    balance: json["balance"].toDouble(),
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
    currencyType: json["currency_type"],
    rate: json["rate"].toDouble(),
    flag: json["flag"],
    imagePath: json["image_path"],
  );

  @override
  // TODO: implement img
  String get img => throw UnimplementedError();

  @override
  // TODO: implement title
  String get title => currencyCode;
}