import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/register_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';

class Step5Controller extends GetxController {
  late RegisterModel registerModel;

  final RxInt partnerMinAge = 18.obs;
  final RxInt partnerMaxAge = 60.obs;
  final RxString partnerMaritalStatus = 'Unmarried'.obs;
  final partnerEducationController = TextEditingController();
  final partnerProfessionController = TextEditingController();
  final partnerJobLocationController = TextEditingController();
  final partnerAnnualIncomeController = TextEditingController();

  final RxBool isLoading = false.obs;

  final _api = ApiService();

  final List<String> maritalStatusOptions = [
    'Unmarried',
    'Divorced',
    'Widowed',
    'Awaiting Divorce',
    "Doesn't Matter",
  ];

  @override
  void onInit() {
    super.onInit();
    registerModel = Get.arguments as RegisterModel;
  }

  @override
  void onClose() {
    partnerEducationController.dispose();
    partnerProfessionController.dispose();
    partnerJobLocationController.dispose();
    partnerAnnualIncomeController.dispose();
    super.onClose();
  }

  Future<void> submitStep5() async {
    isLoading.value = true;
    final response = await _api
        .post(Endpoints.step4(registerModel.registerId), {
          'partnerMaritalStatus': partnerMaritalStatus.value
              .toLowerCase()
              .replaceAll(' ', '-'),
          'partnerEducation': partnerEducationController.text.trim(),
          'partnerProfession': partnerProfessionController.text.trim(),
          'partnerAnnualInacome': partnerAnnualIncomeController.text.trim(),
        }, tag: 'signup_flow');
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      Get.toNamed(Routes.STEP6, arguments: registerModel);
    }
  }
}
