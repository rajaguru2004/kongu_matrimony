import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/register_model.dart';
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
    final response = await _api.post(Endpoints.register, {
      'profileFor': profileFor.value,
      'name': name,
      'phone': phone,
      'gender': gender.value,
    });
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      final data = response['data'] as Map<String, dynamic>;
      final model = RegisterModel.fromJson(data);
      Get.toNamed(Routes.STEP1, arguments: model);
    }
  }
}
