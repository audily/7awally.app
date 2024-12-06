class AddMoneyManualGatewayModel {
  final Data data;

  AddMoneyManualGatewayModel({
    required this.data,
  });

  factory AddMoneyManualGatewayModel.fromJson(Map<String, dynamic> json) => AddMoneyManualGatewayModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final Gateway gateway;
  final List<InputField> inputFields;

  Data({
    required this.gateway,
    required this.inputFields,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    gateway: Gateway.fromJson(json["gateway"]),
    inputFields: List<InputField>.from(json["input_fields"].map((x) => InputField.fromJson(x))),
  );
}

class Gateway {
  final String desc;

  Gateway({
    required this.desc,
  });

  factory Gateway.fromJson(Map<String, dynamic> json) => Gateway(
    desc: json["desc"] ?? "",
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