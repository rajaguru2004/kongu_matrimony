import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/register_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';

class Step7Controller extends GetxController {
  late RegisterModel registerModel;

  final aboutYouController = TextEditingController();
  final RxBool isLoading = false.obs;

  final _api = ApiService();

  @override
  void onInit() {
    super.onInit();
    registerModel = Get.arguments as RegisterModel;
  }

  @override
  void onClose() {
    aboutYouController.dispose();
    super.onClose();
  }

  Future<void> submitStep7() async {
    if (aboutYouController.text.trim().isEmpty) {
      Get.snackbar('Validation', 'Please write something about yourself');
      return;
    }

    isLoading.value = true;
    final response = await _api.post(
      Endpoints.step6(registerModel.registerId),
      {'aboutYou': aboutYouController.text.trim()},
      tag: 'signup_flow',
    );
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      Get.toNamed(Routes.STEP8, arguments: registerModel);
    }
  }
}
