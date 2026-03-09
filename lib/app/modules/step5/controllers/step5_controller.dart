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
  final RxString partnerEducation = ''.obs;
  final RxString partnerProfession = ''.obs;
  final RxString partnerAnnualIncome = ''.obs;
  final partnerJobLocationController = TextEditingController();

  final RxList<String> educationOptions = <String>[].obs;
  final RxList<String> occupationOptions = <String>[].obs;

  final RxBool isLoading = false.obs;

  final _api = ApiService();

  final List<String> maritalStatusOptions = [
    'Unmarried',
    'Divorced',
    'Widowed',
    'Awaiting Divorce',
    "Doesn't Matter",
  ];

  final List<String> incomeOptions = [
    'Below 2 Lakhs',
    '2 - 5 Lakhs',
    '5 - 10 Lakhs',
    '10 - 20 Lakhs',
    'Above 20 Lakhs',
  ];

  @override
  void onInit() {
    super.onInit();
    registerModel = Get.arguments as RegisterModel;
    fetchDropdownData();
  }

  Future<void> fetchDropdownData() async {
    isLoading.value = true;
    try {
      final educationsResponse = await _api.getSetupData(Endpoints.educations);
      if (educationsResponse != null) {
        educationOptions.assignAll(
          educationsResponse.data.map((e) => e.name).toList(),
        );
      }

      final occupationsResponse = await _api.getSetupData(
        Endpoints.occupations,
      );
      if (occupationsResponse != null) {
        occupationOptions.assignAll(
          occupationsResponse.data.map((e) => e.name).toList(),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    partnerJobLocationController.dispose();
    super.onClose();
  }

  Future<void> submitStep5() async {
    isLoading.value = true;
    final response = await _api
        .post(Endpoints.step4(registerModel.registerId), {
          'partnerMaritalStatus': partnerMaritalStatus.value
              .toLowerCase()
              .replaceAll(' ', '-'),
          'partnerEducation': partnerEducation.value.trim(),
          'partnerProfession': partnerProfession.value.trim(),
          'partnerAnnualInacome': partnerAnnualIncome.value.trim(),
        }, tag: 'signup_flow');
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      Get.toNamed(Routes.STEP6, arguments: registerModel);
    }
  }
}
