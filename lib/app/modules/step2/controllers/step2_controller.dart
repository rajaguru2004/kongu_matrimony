import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/register_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';

class Step2Controller extends GetxController {
  late RegisterModel registerModel;

  final RxString maritalStatus = 'Unmarried'.obs;
  final RxString height = ''.obs;
  final RxString familyStatus = 'Middle Class'.obs;
  final RxString familyType = 'Nuclear Family'.obs;
  final RxString familyValues = 'Traditional'.obs;
  final RxString anyDisability = 'No'.obs;
  final RxBool isLoading = false.obs;

  final _api = ApiService();

  final List<String> maritalStatusOptions = [
    'Unmarried',
    'Divorced',
    'Widowed',
    'Awaiting Divorce',
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
    'Lower Middle Class',
    'Middle Class',
    'Upper Middle Class',
    'Rich',
    'Affluent',
  ];

  final List<String> familyTypeOptions = [
    'Nuclear Family',
    'Joint Family',
    'Extended Family',
  ];

  final List<String> familyValuesOptions = [
    'Traditional',
    'Moderate',
    'Liberal',
  ];

  final List<String> disabilityOptions = ['No', 'Yes'];

  @override
  void onInit() {
    super.onInit();
    registerModel = Get.arguments as RegisterModel;
    height.value = heightOptions[12]; // default 5 ft 6 in
  }

  Future<void> submitStep2() async {
    isLoading.value = true;
    final response = await _api
        .post(Endpoints.step2(registerModel.registerId), {
          'maritalStatus': maritalStatus.value,
          'height': height.value,
          'familyStatus': familyStatus.value,
          'familyType': familyType.value,
          'familyValues': familyValues.value,
          'anyDisability': anyDisability.value,
        });
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      Get.toNamed(Routes.STEP3, arguments: registerModel);
    }
  }
}
