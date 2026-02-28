import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';
import 'package:kongu_matrimony/app/data/models/register_model.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();
  final RxBool isLoading = false.obs;

  late String phone;
  late String profileFor;
  late String name;
  late String gender;
  late String smsToken;

  final _api = ApiService();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    phone = args['phone'];
    profileFor = args['profileFor'];
    name = args['name'];
    gender = args['gender'];
    smsToken = args['smsToken'];
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();

    if (otp.length < 4) {
      Get.snackbar(
        'Validation',
        'Please enter the 4-digit OTP',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    final response = await _api.post(Endpoints.verifyOtp, {
      'profileFor': profileFor,
      'name': name,
      'gender': gender,
      'phone': phone,
      'otp': otp,
      'smsToken': smsToken,
    }, tag: 'signup_flow');
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      // Assuming the success response contains registration data or navigates to step1
      // Based on the user's initial_sign_controller, they navigate to STEP1 with RegisterModel
      if (response['data'] != null) {
        final data = response['data'] as Map<String, dynamic>;
        final model = RegisterModel.fromJson(data);
        Get.offAllNamed(Routes.STEP1, arguments: model);
      } else {
        // If data is null, we might need to handle it depending on the actual API response structure
        Get.snackbar('Success', 'Phone verified successfully');
        // Get.toNamed(Routes.STEP1); // Fallback navigation if needed
      }
    } else {
      Get.snackbar(
        'Error',
        response?['message'] ?? 'Invalid OTP',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> resendOtp() async {
    isLoading.value = true;
    final response = await _api.post(Endpoints.sendOtp, {
      'profileFor': profileFor,
      'name': name,
      'gender': gender,
      'phone': phone,
    }, tag: 'signup_flow');
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      smsToken = response['smsToken'];
      Get.snackbar(
        'Success',
        'OTP resent successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
