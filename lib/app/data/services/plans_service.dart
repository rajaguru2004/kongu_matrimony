import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kongu_matrimony/app/data/models/plan_model.dart';
import 'package:kongu_matrimony/app/endpoints.dart';

class PlansService {
  final _dio = Dio();

  /// Fetch all active membership plans.
  Future<List<PlanModel>?> fetchPlans({required String token}) async {
    const url = Endpoints.plans;
    debugPrint('[payment] API REQUEST: $url');
    try {
      final response = await _dio.get(
        url,
        options: Options(headers: {'authorization': 'Bearer $token'}),
      );
      debugPrint('[payment] API RESPONSE: ${response.statusCode}');
      debugPrint('[payment] RESPONSE DATA: ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] as List<dynamic>;
        return data
            .map((e) => PlanModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('[payment] API ERROR: $e');
    }
    return null;
  }

  /// Create a Razorpay order for the given plan.
  Future<Map<String, dynamic>?> createOrder({
    required String planId,
    required String token,
  }) async {
    const url = Endpoints.createOrder;
    final body = {'planId': planId};
    debugPrint('[payment] API REQUEST: $url');
    debugPrint('[payment] REQUEST BODY: $body');
    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
            'content-type': 'application/json',
          },
        ),
      );
      debugPrint('[payment] API RESPONSE: ${response.statusCode}');
      debugPrint('[payment] RESPONSE DATA: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['data'] as Map<String, dynamic>;
      }
    } catch (e) {
      debugPrint('[payment] API ERROR: $e');
    }
    return null;
  }

  /// Verify payment after successful Razorpay transaction.
  Future<Map<String, dynamic>?> verifyPayment({
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
    required String token,
  }) async {
    const url = Endpoints.verifyPayment;
    final body = {
      'razorpayOrderId': razorpayOrderId,
      'razorpayPaymentId': razorpayPaymentId,
      'razorpaySignature': razorpaySignature,
    };
    debugPrint('[payment] API REQUEST: $url');
    debugPrint('[payment] REQUEST BODY: $body');
    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
            'content-type': 'application/json',
          },
        ),
      );
      debugPrint('[payment] API RESPONSE: ${response.statusCode}');
      debugPrint('[payment] RESPONSE DATA: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['data'] as Map<String, dynamic>;
      }
    } catch (e) {
      debugPrint('[payment] API ERROR: $e');
    }
    return null;
  }
}
