import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/register_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';

class Step5Controller extends GetxController {
  late RegisterModel registerModel;

  final partnerCasteController = TextEditingController();
  final partnerKulamController = TextEditingController();
  final RxString partnerHoroscopeType = 'Rasi & Natchathiram'.obs;
  final RxBool isLoading = false.obs;

  final _api = ApiService();

  final List<String> horoscopeOptions = [
    'Rasi & Natchathiram',
    'Rasi Only',
    "Doesn't Matter",
  ];

  @override
  void onInit() {
    super.onInit();
    registerModel = Get.arguments as RegisterModel;
  }

  @override
  void onClose() {
    partnerCasteController.dispose();
    partnerKulamController.dispose();
    super.onClose();
  }

  Future<void> submitStep5() async {
    isLoading.value = true;
    final response = await _api
        .post(Endpoints.step5(registerModel.registerId), {
          'partnerCaste': partnerCasteController.text.trim(),
          'partnerKulam': partnerKulamController.text.trim(),
          'partnerHoroscopeType': partnerHoroscopeType.value,
        });
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      Get.toNamed(Routes.STEP6, arguments: registerModel);
    }
  }
}
