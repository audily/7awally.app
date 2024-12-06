import '../../../widgets/dropdown/custom_dropdown_widget.dart';

class SendMoneyIndexModel {
  final Data data;

  SendMoneyIndexModel({
    required this.data,
  });

  factory SendMoneyIndexModel.fromJson(Map<String, dynamic> json) => SendMoneyIndexModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<ErWallet> userWallet;
  final List<ErWallet> receiverWallets;
  final Charges charges;

  Data({
    required this.userWallet,
    required this.receiverWallets,
    required this.charges,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userWallet: List<ErWallet>.from(json["user_wallet"].map((x) => ErWallet.fromJson(x))),
    receiverWallets: List<ErWallet>.from(json["receiver_wallets"].map((x) => ErWallet.fromJson(x))),
    charges: Charges.fromJson(json["charges"]),
  );
}

class Charges {
  final String title;
  final double fixedCharge;
  final double percentCharge;
  final double minLimit;
  final double maxLimit;
  final double rate;
  final String currencyCode;
  final String currencySymbol;

  Charges({
    required this.title,
    required this.fixedCharge,
    required this.percentCharge,
    required this.minLimit,
    required this.maxLimit,
    required this.rate,
    required this.currencyCode,
    required this.currencySymbol,
  });

  factory Charges.fromJson(Map<String, dynamic> json) => Charges(
    title: json["title"],
    fixedCharge: json["fixed_charge"].toDouble(),
    percentCharge: json["percent_charge"].toDouble(),
    minLimit: json["min_limit"].toDouble(),
    maxLimit: json["max_limit"].toDouble(),
    rate: json["rate"].toDouble(),
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
  );
}

class ErWallet extends DropdownModel{
  final String name;
  final String currencyCode;
  final String currencySymbol;
  final String currencyType;
  final double rate;
  final String flag;
  final String imagePath;
  final double balance;

  ErWallet({
    required this.name,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyType,
    required this.rate,
    required this.flag,
    required this.imagePath,
    required this.balance,
  });

  factory ErWallet.fromJson(Map<String, dynamic> json) => ErWallet(
    name: json["name"],
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
    currencyType: json["currency_type"],
    rate: json["rate"].toDouble(),
    flag: json["flag"],
    imagePath: json["image_path"],
    balance: (json["balance"] ?? 0).toDouble(),
  );

  @override
  // TODO: implement img
  String get img => throw UnimplementedError();

  @override
  // TODO: implement title
  String get title => currencyCode;
}