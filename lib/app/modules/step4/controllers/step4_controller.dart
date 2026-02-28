import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/register_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';

class Step4Controller extends GetxController {
  late RegisterModel registerModel;

  final highestEducationController = TextEditingController();
  final additionalDegreeController = TextEditingController();
  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();
  final workLocationController = TextEditingController();
  final aboutWorkController = TextEditingController();
  final additionalIncomeController = TextEditingController();
  final familyNetWorthController = TextEditingController();
  final otherOccupationController = TextEditingController();

  final RxString employedIn = 'Private'.obs;
  final RxString fatherOccupation = ''.obs;
  final RxString motherOccupation = ''.obs;
  final RxString occupation = ''.obs;
  final RxString annualIncome = ''.obs;

  final RxBool isLoading = false.obs;

  final _api = ApiService();

  final List<String> employedInOptions = [
    'Government/PSU',
    'Private',
    'Business',
    'Defence',
    'Self Employed',
    'Not Working',
    'Enter Myself',
  ];

  final List<String> occupationOptions = [
    'Software Engineer',
    'Teacher/Professor',
    'Doctor',
    'Engineer',
    'Manager',
    'Banker',
    'Police/Military',
    'Farmer',
    'Business Person',
    'Other',
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
  }

  @override
  void onClose() {
    highestEducationController.dispose();
    additionalDegreeController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    workLocationController.dispose();
    aboutWorkController.dispose();
    additionalIncomeController.dispose();
    familyNetWorthController.dispose();
    otherOccupationController.dispose();
    super.onClose();
  }

  Future<void> submitStep4() async {
    if (highestEducationController.text.trim().isEmpty) {
      Get.snackbar('Validation', 'Please enter your highest education');
      return;
    }
    if (occupation.value.isEmpty) {
      Get.snackbar('Validation', 'Please select your occupation');
      return;
    }
    if (annualIncome.value.isEmpty) {
      Get.snackbar('Validation', 'Please select your annual income');
      return;
    }
    if (workLocationController.text.trim().isEmpty) {
      Get.snackbar('Validation', 'Please enter your work location');
      return;
    }

    isLoading.value = true;
    final response = await _api
        .post(Endpoints.step3(registerModel.registerId), {
          'highestEducation': highestEducationController.text
              .trim()
              .toLowerCase()
              .replaceAll(' ', '-'),
          'additionalDegree': additionalDegreeController.text
              .trim()
              .toLowerCase(),
          'employedIn': employedIn.value.toLowerCase().replaceAll('/', '-'),
          'fatherName': fatherNameController.text.trim(),
          'motherName': motherNameController.text.trim(),
          'motherOccupation': motherOccupation.value.toLowerCase().replaceAll(
            ' ',
            '-',
          ),
          'fatherOccupation': fatherOccupation.value.toLowerCase().replaceAll(
            ' ',
            '-',
          ),
          'occupation': occupation.value.toLowerCase().replaceAll(' ', '-'),
          'otherOccupation': otherOccupationController.text.trim(),
          'annualIncome': annualIncome.value.toLowerCase().replaceAll(' ', '-'),
          'workLocation': workLocationController.text.trim(),
          'aboutWork': aboutWorkController.text.trim(),
          'additionalIncome': additionalIncomeController.text.trim(),
          'familyNetWorth': familyNetWorthController.text.trim(),
        }, tag: 'signup_flow');
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      Get.toNamed(Routes.STEP5, arguments: registerModel);
    }
  }
}
