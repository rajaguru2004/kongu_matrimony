import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/register_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';

class Step6Controller extends GetxController {
  late RegisterModel registerModel;

  final RxString partnerCaste = 'Any'.obs;
  final RxString partnerKootam = 'Any'.obs;
  final RxString partnerStar = 'Any'.obs;
  final RxString partnerRasi = 'Any'.obs;
  final RxString partnerDosham = 'No'.obs;

  final RxBool isLoading = false.obs;

  final _api = ApiService();

  final List<String> rasiOptions = [
    'Any',
    'Mesham',
    'Rishabam',
    'Midhunam',
    'Kadagam',
    'Simmam',
    'Kanni',
    'Thulaam',
    'Viruchigam',
    'Dhanusu',
    'Magaram',
    'Kumbam',
    'Meenam',
  ];

  final List<String> starOptions = [
    'Any',
    'Ashwini',
    'Bharani',
    'Krithigai',
    'Rohini',
    'Mirugaseerishum',
    'Thiruvadhirai',
    'Punarpusam',
    'Poosam',
    'Ayilyam',
    'Magam',
    'Pooram',
    'Uthiram',
    'Hastham',
    'Chithirai',
    'Swathi',
    'Visagam',
    'Anusham',
    'Kettai',
    'Moolam',
    'Pooradam',
    'Uthiradam',
    'Thiruvonam',
    'Avittam',
    'Sadhayam',
    'Pooratathi',
    'Uthiratathi',
    'Revathi',
  ];

  @override
  void onInit() {
    super.onInit();
    registerModel = Get.arguments as RegisterModel;
  }

  Future<void> submitStep6() async {
    isLoading.value = true;
    final response = await _api.post(
      Endpoints.step5(registerModel.registerId),
      {
        'partnerCaste': partnerCaste.value.toLowerCase(),
        'partnerKulam': partnerKootam.value.toLowerCase().replaceAll('any', ''),
        'partnerStar': partnerStar.value.toLowerCase(),
        'partnerRasi': partnerRasi.value.toLowerCase(),
        'partnerDosham': partnerDosham.value.toLowerCase(),
      },
      tag: 'signup_flow',
    );
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      Get.toNamed(Routes.STEP7, arguments: registerModel);
    }
  }
}
