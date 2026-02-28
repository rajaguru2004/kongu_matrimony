import 'user_model.dart';

class LoginResponseModel {
  final bool success;
  final String message;
  final UserModel? user;
  final String? token;
  final String? role;

  LoginResponseModel({
    required this.success,
    required this.message,
    this.user,
    this.token,
    this.role,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      user: json['data'] != null && json['data']['user'] != null
          ? UserModel.fromJson(json['data']['user'])
          : null,
      token: json['data'] != null ? json['data']['token'] : null,
      role: json['data'] != null ? json['data']['role'] : null,
    );
  }
}
