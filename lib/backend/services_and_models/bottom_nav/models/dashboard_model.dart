class DashboardModel {
  final Data data;

  DashboardModel({
    required this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final UserInfo userInfo;
  final List<Wallet> wallets;
  final List<RecentTransaction> recentTransactions;
  final ProfileImagePaths profileImagePaths;

  Data({
    required this.userInfo,
    required this.wallets,
    required this.recentTransactions,
    required this.profileImagePaths,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userInfo: UserInfo.fromJson(json["user_info"]),
    wallets: List<Wallet>.from(json["wallets"].map((x) => Wallet.fromJson(x))),
    recentTransactions: List<RecentTransaction>.from(json["recent_transactions"].map((x) => RecentTransaction.fromJson(x))),
    profileImagePaths: ProfileImagePaths.fromJson(json["profile_image_paths"]),
  );
}

class ProfileImagePaths {
  final String baseUrl;
  final String pathLocation;
  final String defaultImage;

  ProfileImagePaths({
    required this.baseUrl,
    required this.pathLocation,
    required this.defaultImage,
  });

  factory ProfileImagePaths.fromJson(Map<String, dynamic> json) => ProfileImagePaths(
    baseUrl: json["base_url"],
    pathLocation: json["path_location"],
    defaultImage: json["default_image"],
  );
}

class RecentTransaction {
  final String type;
  final String attribute;
  final String trxId;
  final dynamic adminId;
  final dynamic merchantId;
  final dynamic merchantWalletId;
  final dynamic sandboxWalletId;
  final dynamic requestMoneyId;
  final dynamic voucherId;
  final String requestCurrency;
  final double receiveAmount;
  final int status;
  final DateTime createdAt;

  RecentTransaction({
    required this.type,
    required this.attribute,
    required this.trxId,
    required this.adminId,
    required this.merchantId,
    required this.merchantWalletId,
    required this.sandboxWalletId,
    required this.requestMoneyId,
    required this.voucherId,
    required this.requestCurrency,
    required this.receiveAmount,
    required this.status,
    required this.createdAt,
  });

  factory RecentTransaction.fromJson(Map<String, dynamic> json) => RecentTransaction(
    type: json["type"],
    attribute: json["attribute"] ?? "",
    trxId: json["trx_id"],
    adminId: json["admin_id"] ?? "",
    merchantId: json["merchant_id"] ?? "",
    merchantWalletId: json["merchant_wallet_id"] ?? "",
    sandboxWalletId: json["sandbox_wallet_id"] ?? "",
    requestMoneyId: json["request_money_id"] ?? "",
    voucherId: json["voucher_id"] ?? "",
    requestCurrency: json["request_currency"],
    receiveAmount: json["receive_amount"].toDouble(),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}

class UserInfo {
  final String fullname;
  final String username;
  final dynamic image;
  final int kycVerified;

  UserInfo({
    required this.fullname,
    required this.username,
    required this.image,
    required this.kycVerified,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    fullname: json["fullname"],
    username: json["username"],
    image: json["image"] ?? "",
    kycVerified: json["kyc_verified"],
  );
}

class Wallet {
  final String name;
  final double balance;
  final String currencyCode;
  final String currencySymbol;
  final String currencyType;
  final double rate;
  final String flag;
  final String imagePath;

  Wallet({
    required this.name,
    required this.balance,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyType,
    required this.rate,
    required this.flag,
    required this.imagePath,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    name: json["name"],
    balance: json["balance"].toDouble(),
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
    currencyType: json["currency_type"],
    rate: json["rate"].toDouble(),
    flag: json["flag"] ?? "",
    imagePath: json["image_path"],
  );
}