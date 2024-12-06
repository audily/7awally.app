import 'register_model.dart';

class LoginModel {
  final Data data;

  LoginModel({
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String token;
  final Authorization authorization;
  final UserInfo userInfo;

  Data({
    required this.token,
    required this.userInfo,
    required this.authorization
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    userInfo: UserInfo.fromJson(json["user_info"]),
    authorization: Authorization.fromJson(json["authorization"]),
  );
}

class UserInfo {
  final int emailVerified;
  final int kycVerified;
  final int twoFactorVerified;
  final int twoFactorStatus;

  UserInfo({
    required this.emailVerified,
    required this.kycVerified,
    required this.twoFactorVerified,
    required this.twoFactorStatus,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    emailVerified: json["email_verified"],
    kycVerified: json["kyc_verified"],
    twoFactorVerified: json["two_factor_verified"],
    twoFactorStatus: json["two_factor_status"],
  );
}