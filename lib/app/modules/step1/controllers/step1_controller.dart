import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kongu_matrimony/app/data/models/register_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';

class Step1Controller extends GetxController {
  late RegisterModel registerModel;

  final emailController = TextEditingController();
  final alternatePhoneController = TextEditingController();
  final placeOfBirthController = TextEditingController();
  final addressController = TextEditingController();
  final pincodeController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();

  final RxString dob = ''.obs;
  final RxString timeOfBirth = ''.obs;
  final RxString identityProofFrontPath = ''.obs;
  final RxString identityProofBackPath = ''.obs;
  final RxString parentIdentityFrontPath = ''.obs;
  final RxString parentIdentityBackPath = ''.obs;
  final RxBool isLoading = false.obs;

  final _api = ApiService();
  final _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    registerModel = Get.arguments as RegisterModel;
  }

  @override
  void onClose() {
    emailController.dispose();
    alternatePhoneController.dispose();
    placeOfBirthController.dispose();
    addressController.dispose();
    pincodeController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.onClose();
  }

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFFE07B39)),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      dob.value = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFFE07B39)),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
      timeOfBirth.value = '$hour:$minute $period';
    }
  }

  Future<void> pickImage(String field) async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      switch (field) {
        case 'identityFront':
          identityProofFrontPath.value = file.path;
          break;
        case 'identityBack':
          identityProofBackPath.value = file.path;
          break;
        case 'parentFront':
          parentIdentityFrontPath.value = file.path;
          break;
        case 'parentBack':
          parentIdentityBackPath.value = file.path;
          break;
      }
    }
  }

  Future<void> submitStep1() async {
    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation',
        'Please enter your email',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (dob.value.isEmpty) {
      Get.snackbar(
        'Validation',
        'Please select your date of birth',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (placeOfBirthController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation',
        'Please enter your place of birth',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    // Upload images first
    final idFrontUrl = await _uploadFile(
      identityProofFrontPath.value,
      'id-proofs',
    );
    final idBackUrl = await _uploadFile(
      identityProofBackPath.value,
      'id-proofs',
    );
    final parentFrontUrl = await _uploadFile(
      parentIdentityFrontPath.value,
      'parent-id-proofs',
    );
    final parentBackUrl = await _uploadFile(
      parentIdentityBackPath.value,
      'parent-id-proofs',
    );

    final response = await _api
        .post(Endpoints.step1(registerModel.registerId), {
          'email': emailController.text.trim(),
          'alternatePhone': alternatePhoneController.text.trim(),
          'placeOfBirth': placeOfBirthController.text.trim(),
          'address': addressController.text.trim(),
          'pincode': pincodeController.text.trim(),
          'state': stateController.text.trim(),
          'country': countryController.text.trim(),
          'identityProofFront': idFrontUrl ?? '',
          'identityProofBack': idBackUrl ?? '',
          'parentIdentityFront': parentFrontUrl ?? '',
          'parentIdentityBack': parentBackUrl ?? '',
          'timeOfBirth': timeOfBirth.value,
          'dob': dob.value,
        }, tag: 'signup_flow');
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      Get.toNamed(Routes.STEP2, arguments: registerModel);
    }
  }

  Future<String?> _uploadFile(String filePath, String pathName) async {
    if (filePath.isEmpty) return null;

    final response = await _api.uploadImage(
      filePath: filePath,
      pathName: pathName,
      id: registerModel.registerId,
      tag: 'image_upload',
    );

    if (response != null && response['success'] == true) {
      return response['data'] as String?;
    }
    return null;
  }
}
