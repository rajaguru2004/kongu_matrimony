import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:kongu_matrimony/app/endpoints.dart';

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
    Map<String, dynamic> data, {
    String? tag,
  }) async {
    if (tag != null) {
      debugPrint('[$tag] API REQUEST: $url');
      debugPrint('[$tag] REQUEST BODY: $data');
    }
    try {
      final response = await _dio.post(url, data: data);

      if (tag != null) {
        debugPrint('[$tag] API RESPONSE: ${response.statusCode}');
        debugPrint('[$tag] RESPONSE DATA: ${response.data}');
      }

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

  Future<Map<String, dynamic>?> uploadImage({
    required String filePath,
    required String pathName,
    required String id,
    String? tag,
  }) async {
    if (tag != null) {
      debugPrint('[$tag] UPLOAD REQUEST: ${Endpoints.uploadImage}');
      debugPrint('[$tag] FILE: $filePath, PATH: $pathName, ID: $id');
    }
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(filePath),
        'pathName': pathName,
        'id': id,
      });

      final response = await _dio.post(
        Endpoints.uploadImage,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (tag != null) {
        debugPrint('[$tag] UPLOAD RESPONSE: ${response.statusCode}');
        debugPrint('[$tag] RESPONSE DATA: ${response.data}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data as Map<String, dynamic>;
      } else {
        _showError('Upload error: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      final message =
          e.response?.data?['message'] ??
          e.message ??
          'Upload failed. Please try again.';
      _showError(message.toString());
      return null;
    } catch (e) {
      _showError('Unexpected upload error: $e');
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
