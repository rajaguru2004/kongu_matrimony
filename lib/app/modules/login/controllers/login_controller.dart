import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/login_response_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/data/services/auth_service.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isOtpSent = false.obs;
  final RxString smsToken = ''.obs;

  final _api = ApiService();

  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    super.onClose();
  }

  Future<void> sendOtp() async {
    final phone = phoneController.text.trim();
    if (phone.length != 10) {
      Get.snackbar('Validation', 'Please enter a valid 10-digit phone number');
      return;
    }

    isLoading.value = true;
    final response = await _api.post(Endpoints.loginSendOtp, {
      'phone': phone,
      'email': '',
      'type': 'login',
    }, tag: 'login_flow');
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      smsToken.value = response['smsToken'] ?? '';
      isOtpSent.value = true;
      Get.snackbar('Success', 'OTP sent successfully');
    }
  }

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();
    if (otp.length < 4) {
      Get.snackbar('Validation', 'Please enter a valid OTP');
      return;
    }

    isLoading.value = true;
    final response = await _api.post(Endpoints.loginVerifyOtp, {
      'phone': phoneController.text.trim(),
      'otp': otp,
      'smsToken': smsToken.value,
    }, tag: 'login_flow');
    isLoading.value = false;

    if (response != null) {
      final loginResponse = LoginResponseModel.fromJson(response);
      if (loginResponse.success && loginResponse.user != null) {
        AuthService.to.login(
          loginResponse.token ?? '',
          loginResponse.user?.registerId ?? '',
        );
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar('Error', loginResponse.message);
      }
    }
  }

  void resetLogin() {
    isOtpSent.value = false;
    otpController.clear();
  }
}
