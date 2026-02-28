import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kongu_matrimony/app/data/models/register_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';

class Step8Controller extends GetxController {
  late RegisterModel registerModel;

  final RxString profilePhotoPath = ''.obs;
  final RxBool isLoading = false.obs;

  final _api = ApiService();
  final _picker = ImagePicker();

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

  Future<void> submitStep8() async {
    isLoading.value = true;

    String? uploadedUrl;
    if (profilePhotoPath.value.isNotEmpty) {
      final uploadResponse = await _api.uploadImage(
        filePath: profilePhotoPath.value,
        pathName: 'profile-photos',
        id: registerModel.registerId,
        tag: 'image_upload',
      );
      if (uploadResponse != null && uploadResponse['success'] == true) {
        uploadedUrl = uploadResponse['data'];
      }
    }

    final response = await _api.post(
      Endpoints.step7(registerModel.registerId),
      {'profilePhotoUrl': uploadedUrl ?? ''},
      tag: 'signup_flow',
    );
    isLoading.value = false;

    if (response != null && response['success'] == true) {
      Get.offAllNamed(Routes.HOME);
    }
  }
}
