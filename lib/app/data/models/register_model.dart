class RegisterModel {
  final int id;
  final String registerId;
  final String profileFor;
  final String name;
  final String phone;
  final String gender;

  RegisterModel({
    required this.id,
    required this.registerId,
    required this.profileFor,
    required this.name,
    required this.phone,
    required this.gender,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      id: json['id'] ?? 0,
      registerId: json['registerId'] ?? '',
      profileFor: json['profileFor'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'] ?? '',
    );
  }
}
