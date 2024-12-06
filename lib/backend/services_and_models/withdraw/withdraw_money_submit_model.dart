class WithdrawMoneySubmitModel {
  final Data data;

  WithdrawMoneySubmitModel({
    required this.data,
  });

  factory WithdrawMoneySubmitModel.fromJson(Map<String, dynamic> json) => WithdrawMoneySubmitModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final PaymentInformations paymentInformations;
  final String gatewayType;
  final String gatewayCurrencyName;
  final String alias;
  final String details;
  final List<InputField> inputFields;

  Data({
    required this.paymentInformations,
    required this.gatewayType,
    required this.gatewayCurrencyName,
    required this.alias,
    required this.details,
    required this.inputFields,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    paymentInformations: PaymentInformations.fromJson(json["payment_informations"]),
    gatewayType: json["gateway_type"],
    gatewayCurrencyName: json["gateway_currency_name"],
    alias: json["alias"],
    details: json["details"],
    inputFields: List<InputField>.from(json["input_fields"].map((x) => InputField.fromJson(x))),
  );
}

class InputField {
  final String type;
  final String label;
  final String name;
  final bool required;
  final Validation validation;

  InputField({
    required this.type,
    required this.label,
    required this.name,
    required this.required,
    required this.validation,
  });

  factory InputField.fromJson(Map<String, dynamic> json) => InputField(
    type: json["type"],
    label: json["label"],
    name: json["name"],
    required: json["required"],
    validation: Validation.fromJson(json["validation"]),
  );
}

class Validation {
  final dynamic max;
  final List<String> mimes;
  final dynamic min;
  final List<String> options;
  final bool required;

  Validation({
    required this.max,
    required this.mimes,
    required this.min,
    required this.options,
    required this.required,
  });

  factory Validation.fromJson(Map<String, dynamic> json) => Validation(
    max: json["max"],
    mimes: List<String>.from(json["mimes"].map((x) => x)),
    min: json["min"],
    options: List<String>.from(json["options"].map((x) => x)),
    required: json["required"],
  );
}

class PaymentInformations {
  final String trx;
  final String gatewayCurrencyName;
  final String requestAmount;
  final String exchangeRate;
  final String conversionAmount;
  final String totalCharge;
  final String willGet;
  final String payable;

  PaymentInformations({
    required this.trx,
    required this.gatewayCurrencyName,
    required this.requestAmount,
    required this.exchangeRate,
    required this.conversionAmount,
    required this.totalCharge,
    required this.willGet,
    required this.payable,
  });

  factory PaymentInformations.fromJson(Map<String, dynamic> json) => PaymentInformations(
    trx: json["trx"],
    gatewayCurrencyName: json["gateway_currency_name"],
    requestAmount: json["request_amount"],
    exchangeRate: json["exchange_rate"],
    conversionAmount: json["conversion_amount"],
    totalCharge: json["total_charge"],
    willGet: json["will_get"],
    payable: json["payable"],
  );
}