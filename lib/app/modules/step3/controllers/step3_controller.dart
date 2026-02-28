import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/register_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';

class Step3Controller extends GetxController {
  late RegisterModel registerModel;

  final RxString maritalStatus = 'Single'.obs;
  final RxString height = ''.obs;
  final RxString familyStatus = ''.obs;
  final RxString familyType = ''.obs;
  final RxString familyValues = ''.obs;
  final RxString anyDisability = 'None'.obs;
  final RxBool isLoading = false.obs;

  final _api = ApiService();

  final List<String> maritalStatusOptions = [
    'Married',
    'Single',
    'Divorced',
    'Widowed',
  ];

  final List<String> heightOptions = [
    '4 ft 6 in',
    '4 ft 7 in',
    '4 ft 8 in',
    '4 ft 9 in',
    '4 ft 10 in',
    '4 ft 11 in',
    '5 ft 0 in',
    '5 ft 1 in',
    '5 ft 2 in',
    '5 ft 3 in',
    '5 ft 4 in',
    '5 ft 5 in',
    '5 ft 6 in',
    '5 ft 7 in',
    '5 ft 8 in',
    '5 ft 9 in',
    '5 ft 10 in',
    '5 ft 11 in',
    '6 ft 0 in',
    '6 ft 1 in',
    '6 ft 2 in',
    '6 ft 3 in',
  ];

  final List<String> familyStatusOptions = [
    'Lower Class',
    'Middle Class',
    'Upper Middle Class',
    'Rich',
  ];

  final List<String> familyTypeOptions = ['Joint', 'Nuclear'];

  final List<String> familyValuesOptions = [
    'Traditional',
    'Moderate',
    'Liberal',
    'Orthodox',
    'Conservative',
    'Progressive',
  ];

  final List<String> disabilityOptions = ['None', 'Physically Challenged'];

  @override
  void onInit() {
    super.onInit();
    registerModel = Get.arguments as RegisterModel;
  }

  Future<void> submitStep3() async {
    isLoading.value = true;
    final response = await _api.post(
      Endpoints.step2(registerModel.registerId),
      {
        'maritalStatus': maritalStatus.value.toLowerCase(),
        'height': height.value,
        'familyStatus': familyStatus.value.toLowerCase().replaceAll(' ', '-'),
        'familyType': familyType.value.toLowerCase(),
        'familyValues': familyValues.value.toLowerCase(),
        'anyDisability': anyDisability.value.toLowerCase().replaceAll(' ', '-'),
      },
      tag: 'signup_flow',
    );
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      Get.toNamed(Routes.STEP4, arguments: registerModel);
    }
  }
}
