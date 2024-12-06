class AddMoneyAutomaticSubmitModel {
  final Data data;

  AddMoneyAutomaticSubmitModel({
    required this.data,
  });

  factory AddMoneyAutomaticSubmitModel.fromJson(Map<String, dynamic> json) => AddMoneyAutomaticSubmitModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String redirectUrl;

  Data({
    required this.redirectUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    redirectUrl: json["redirect_url"],
  );
}