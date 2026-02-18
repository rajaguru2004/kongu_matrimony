import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/register_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';

class Step3Controller extends GetxController {
  late RegisterModel registerModel;

  final highestEducationController = TextEditingController();
  final additionalDegreeController = TextEditingController();
  final occupationController = TextEditingController();
  final otherOccupationController = TextEditingController();
  final annualIncomeController = TextEditingController();
  final professionController = TextEditingController();
  final workLocationController = TextEditingController();
  final additionalIncomeController = TextEditingController();
  final familyNetWorthController = TextEditingController();

  final RxString employedIn = 'Private Sector'.obs;
  final RxBool isLoading = false.obs;

  final _api = ApiService();

  final List<String> employedInOptions = [
    'Private Sector',
    'Government / PSU',
    'Business / Self Employed',
    'Defence',
    'Not Working',
  ];

  @override
  void onInit() {
    super.onInit();
    registerModel = Get.arguments as RegisterModel;
  }

  @override
  void onClose() {
    highestEducationController.dispose();
    additionalDegreeController.dispose();
    occupationController.dispose();
    otherOccupationController.dispose();
    annualIncomeController.dispose();
    professionController.dispose();
    workLocationController.dispose();
    additionalIncomeController.dispose();
    familyNetWorthController.dispose();
    super.onClose();
  }

  Future<void> submitStep3() async {
    if (highestEducationController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation',
        'Please enter your highest education',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    final response = await _api
        .post(Endpoints.step3(registerModel.registerId), {
          'highestEducation': highestEducationController.text.trim(),
          'additionalDegree': additionalDegreeController.text.trim(),
          'employedIn': employedIn.value,
          'occupation': occupationController.text.trim(),
          'otherOccupation': otherOccupationController.text.trim(),
          'annualIncome': annualIncomeController.text.trim(),
          'profession': professionController.text.trim(),
          'workLocation': workLocationController.text.trim(),
          'additionalIncome': additionalIncomeController.text.trim(),
          'familyNetWorth': familyNetWorthController.text.trim(),
        });
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      Get.toNamed(Routes.STEP4, arguments: registerModel);
    }
  }
}
