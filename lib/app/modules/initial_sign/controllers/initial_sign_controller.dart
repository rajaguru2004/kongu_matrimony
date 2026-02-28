import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';

class InitialSignController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final RxString profileFor = 'self'.obs;
  final RxString gender = 'male'.obs;
  final RxBool isLoading = false.obs;

  final _api = ApiService();

  final List<Map<String, String>> profileForOptions = [
    {'value': 'self', 'label': 'Myself'},
    {'value': 'son', 'label': 'Son'},
    {'value': 'daughter', 'label': 'Daughter'},
    {'value': 'brother', 'label': 'Brother'},
    {'value': 'sister', 'label': 'Sister'},
    {'value': 'relative', 'label': 'Relative'},
    {'value': 'friend', 'label': 'Friend'},
  ];

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  Future<void> register() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty) {
      Get.snackbar(
        'Validation',
        'Please enter your name',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (phone.isEmpty || phone.length < 10) {
      Get.snackbar(
        'Validation',
        'Please enter a valid 10-digit phone number',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    final payload = {
      'profileFor': profileFor.value,
      'name': name,
      'phone': phone,
      'gender': gender.value,
    };

    final response = await _api.post(
      Endpoints.sendOtp,
      payload,
      tag: 'signup_flow',
    );
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      Get.toNamed(
        Routes.OTP,
        arguments: {...payload, 'smsToken': response['smsToken']},
      );
    } else {
      Get.snackbar(
        'Error',
        response?['message'] ?? 'Failed to send OTP',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
