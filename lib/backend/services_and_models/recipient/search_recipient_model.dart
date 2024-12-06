class SearchRecipientModel {
  final Message message;
  final Data data;

  SearchRecipientModel({
    required this.message,
    required this.data,
  });

  factory SearchRecipientModel.fromJson(Map<String, dynamic> json) => SearchRecipientModel(
    message: Message.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final UserData userData;

  Data({
    required this.userData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userData: UserData.fromJson(json["user_data"]),
  );
}

class UserData {
  final int id;
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final Address address;

  UserData({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.address,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    username: json["username"],
    email: json["email"],
    address: Address.fromJson(json["address"]),
  );
}

class Address {
  final String country;
  final String state;
  final String city;
  final String zip;
  final String address;

  Address({
    required this.country,
    required this.state,
    required this.city,
    required this.zip,
    required this.address,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    country: json["country"],
    state: json["state"] ?? "",
    city: json["city"] ?? "",
    zip: json["zip"] ?? "",
    address: json["address"] ?? "",
  );
}

class Message {
  final List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    success: List<String>.from(json["success"].map((x) => x)),
  );
}