import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/register_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';

class Step8Controller extends GetxController {
  late RegisterModel registerModel;

  final yourCasteController = TextEditingController();
  final yourKootamController = TextEditingController();
  final RxString yourDosham = 'No Dosham'.obs;
  final yourStarController = TextEditingController();
  final yourRasiController = TextEditingController();
  final RxBool isLoading = false.obs;

  final _api = ApiService();

  final List<String> doshamOptions = [
    'No Dosham',
    'Chevvai Dosham',
    'Rahu / Kethu Dosham',
    "Doesn't Matter",
  ];

  @override
  void onInit() {
    super.onInit();
    registerModel = Get.arguments as RegisterModel;
  }

  @override
  void onClose() {
    yourCasteController.dispose();
    yourKootamController.dispose();
    yourStarController.dispose();
    yourRasiController.dispose();
    super.onClose();
  }

  Future<void> submitStep8() async {
    if (yourCasteController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation',
        'Please enter your caste',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    final response = await _api
        .post(Endpoints.yourCaste(registerModel.registerId), {
          'yourCaste': yourCasteController.text.trim(),
          'yourKootam': yourKootamController.text.trim(),
          'yourDosham': yourDosham.value,
          'yourStar': yourStarController.text.trim(),
          'yourRasi': yourRasiController.text.trim(),
        });
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      Get.offAllNamed(Routes.HOME);
    }
  }
}
