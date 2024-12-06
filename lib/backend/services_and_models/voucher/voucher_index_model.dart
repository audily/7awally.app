import '../../../widgets/dropdown/custom_dropdown_widget.dart';

class VoucherIndexModel {
  final Data data;

  VoucherIndexModel({
    required this.data,
  });

  factory VoucherIndexModel.fromJson(Map<String, dynamic> json) => VoucherIndexModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<UserWallet> userWallet;
  final Charges charges;

  Data({
    required this.userWallet,
    required this.charges,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userWallet: List<UserWallet>.from(json["user_wallet"].map((x) => UserWallet.fromJson(x))),
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