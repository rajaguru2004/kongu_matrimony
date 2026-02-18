import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kongu_matrimony/app/data/models/register_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';

class Step7Controller extends GetxController {
  late RegisterModel registerModel;

  final RxString profilePhotoPath = ''.obs;
  final RxBool isLoading = false.obs;

  final _api = ApiService();
  final _picker = ImagePicker();

  // Sample URL sent to backend
  static const String _samplePhotoUrl =
      'https://api.konguelitematrimony.co.in/uploads/sample-profile.jpg';

  @override
  void onInit() {
    super.onInit();
    registerModel = Get.arguments as RegisterModel;
  }

  Future<void> pickProfilePhoto() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (file != null) {
      profilePhotoPath.value = file.path;
    }
  }

  Future<void> submitStep7() async {
    isLoading.value = true;
    final response = await _api.post(
      Endpoints.step7(registerModel.registerId),
      {
        'profilePhotoUrl': profilePhotoPath.value.isNotEmpty
            ? _samplePhotoUrl
            : '',
      },
    );
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      Get.toNamed(Routes.STEP8, arguments: registerModel);
    }
  }
}
