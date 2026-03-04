import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:kongu_matrimony/app/data/models/matches_response_model.dart';
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

  Future<Map<String, dynamic>?> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    String? token,
    String? tag,
  }) async {
    if (tag != null) {
      debugPrint('[$tag] API GET REQUEST: $url');
      debugPrint('[$tag] QUERY PARAMETERS: $queryParameters');
    }
    try {
      final options = token != null
          ? Options(headers: {'Authorization': 'Bearer $token'})
          : null;

      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
      );

      if (tag != null) {
        debugPrint('[$tag] API RESPONSE: ${response.statusCode}');
        debugPrint('[$tag] RESPONSE DATA: ${response.data}');
      }

      if (response.statusCode == 200) {
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

  Future<MatchesResponseModel?> getMatches({
    required String registerId,
    required String token,
    int page = 1,
    int limit = 8,
  }) async {
    final response = await get(
      Endpoints.matches,
      queryParameters: {
        'page': page,
        'limit': limit,
        'search': '',
        'sortOrder': 'DESC',
        'sortBy': 'createdAt',
        'id': registerId,
      },
      token: token,
      tag: 'fetch_matches',
    );

    if (response != null) {
      return MatchesResponseModel.fromJson(response);
    }
    return null;
  }

  /// Daily Recommendations — sorted DESC by createdAt
  Future<MatchesResponseModel?> getDailyRecommendations({
    required String registerId,
    String? token,
    int page = 1,
    int limit = 8,
  }) async {
    final response = await get(
      Endpoints.matches,
      queryParameters: {
        'page': page,
        'limit': limit,
        'sortOrder': 'DESC',
        'sortBy': 'createdAt',
        'id': registerId,
      },
      token: token,
      tag: 'daily_recommendations',
    );

    if (response != null) {
      return MatchesResponseModel.fromJson(response);
    }
    return null;
  }

  /// Your Matches — preference-based
  Future<MatchesResponseModel?> getYourMatches({
    required String registerId,
    String? token,
    int page = 1,
    int limit = 8,
  }) async {
    final response = await get(
      Endpoints.matches,
      queryParameters: {'page': page, 'limit': limit, 'id': registerId},
      token: token,
      tag: 'your_matches',
    );

    if (response != null) {
      return MatchesResponseModel.fromJson(response);
    }
    return null;
  }

  /// Recently Joined — profiles registered in the last 7 days
  Future<MatchesResponseModel?> getRecentlyJoined({
    required String registerId,
    String? token,
    int page = 1,
    int limit = 8,
  }) async {
    final now = DateTime.now();
    final cutoff = now.subtract(const Duration(days: 7));
    final dateStr =
        '${cutoff.year}-${cutoff.month.toString().padLeft(2, '0')}-${cutoff.day.toString().padLeft(2, '0')}';

    final response = await get(
      Endpoints.matches,
      queryParameters: {
        'page': page,
        'limit': limit,
        'createdDate': dateStr,
        'sortOrder': 'DESC',
        'sortBy': 'createdAt',
        'id': registerId,
      },
      token: token,
      tag: 'recently_joined',
    );

    if (response != null) {
      return MatchesResponseModel.fromJson(response);
    }
    return null;
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
