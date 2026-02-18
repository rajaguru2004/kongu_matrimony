import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  Future<Map<String, dynamic>?> post(
    String url,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _dio.post(url, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data as Map<String, dynamic>;
      } else {
        _showError('Server error: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      final message =
          e.response?.data?['message'] ??
          e.message ??
          'Something went wrong. Please try again.';
      _showError(message.toString());
      return null;
    } catch (e) {
      _showError('Unexpected error: $e');
      return null;
    }
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFE53935),
      colorText: const Color(0xFFFFFFFF),
      duration: const Duration(seconds: 3),
    );
  }
}
