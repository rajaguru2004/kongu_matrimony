import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kongu_matrimony/app/data/models/register_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';

class Step2Controller extends GetxController {
  late RegisterModel registerModel;

  final kootamController = TextEditingController();
  final RxString caste = ''.obs;
  final RxString rasi = ''.obs;
  final RxString star = ''.obs;
  final RxString dosham = ''.obs;
  final RxString horoscopeFileUrl = ''.obs;
  final RxString horoscopeFilePath = ''.obs;
  final RxBool isLoading = false.obs;

  final _api = ApiService();
  final _picker = ImagePicker();

  final List<String> casteOptions = [
    'Kongu Vellalar Gounder',
    'Vettuva Gounder',
    'Nattu Gounder',
  ];

  final List<String> rasiOptions = [
    'Mesham (Aries)',
    'Rishapam (Taurus)',
    'Mithunam (Gemini)',
    'Kadagam (Cancer)',
    'Simmam (Leo)',
    'Kanni (Virgo)',
    'Thulam (Libra)',
    'Viruchigam (Scorpio)',
    'Dhanusu (Sagittarius)',
    'Magaram (Capricorn)',
    'Kumbam (Aquarius)',
    'Meenam (Pisces)',
  ];

  final List<String> starOptions = [
    'Ashwini',
    'Bharani',
    'Karthigai',
    'Rohini',
    'Mrigashirsha',
    'Arudra',
    'Punarvasu',
    'Pushya',
    'Ashlesha',
    'Magha',
    'Purva Phalguni',
    'Uttara Phalguni',
    'Hasta',
    'Chitra',
    'Swati',
    'Vishakha',
    'Anuradha',
    'Jyeshtha',
    'Mula',
    'Purva Ashadha',
    'Uttara Ashadha',
    'Shravana',
    'Dhanishta',
    'Shatabhisha',
    'Purva Bhadrapada',
    'Uttara Bhadrapada',
    'Revati',
  ];

  final List<String> doshamOptions = [
    'None',
    'Sevvai Dosham',
    'Sarpa Dosham (Ragu/Kethu)',
    'Kala Sarpa Dosham',
  ];

  @override
  void onInit() {
    super.onInit();
    registerModel = Get.arguments as RegisterModel;
  }

  @override
  void onClose() {
    kootamController.dispose();
    super.onClose();
  }

  Future<void> pickHoroscope() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      horoscopeFilePath.value = file.path;
    }
  }

  Future<void> submitStep2() async {
    if (rasi.value.isEmpty) {
      Get.snackbar('Validation', 'Please select your Rasi');
      return;
    }
    if (star.value.isEmpty) {
      Get.snackbar('Validation', 'Please select your Star');
      return;
    }

    isLoading.value = true;

    String? uploadedUrl;
    if (horoscopeFilePath.value.isNotEmpty) {
      final response = await _api.uploadImage(
        filePath: horoscopeFilePath.value,
        pathName: 'horoscopes',
        id: registerModel.registerId,
        tag: 'image_upload',
      );
      if (response != null && response['success'] == true) {
        uploadedUrl = response['data'];
      }
    }

    final response = await _api
        .post(Endpoints.yourCaste(registerModel.registerId), {
          'yourCaste': caste.value,
          'yourKootam': kootamController.text.trim(),
          'yourRasi': rasi.value
              .toLowerCase()
              .replaceAll(' ', '-')
              .replaceAll('(', '')
              .replaceAll(')', ''),
          'yourStar': star.value.toLowerCase(),
          'yourDosham': dosham.value
              .toLowerCase()
              .replaceAll(' ', '-')
              .replaceAll('(', '')
              .replaceAll(')', ''),
          'yourHoroscopeType': '',
          'yourHoroscopeFileUrl': uploadedUrl ?? '',
        }, tag: 'signup_flow');

    isLoading.value = false;

    if (response != null && response['success'] == true) {
      Get.toNamed(Routes.STEP3, arguments: registerModel);
    }
  }
}
