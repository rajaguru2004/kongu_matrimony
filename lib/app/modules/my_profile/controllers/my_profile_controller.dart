import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio_lib;
import '../../../data/models/user_model.dart';
import '../../../data/services/auth_service.dart';
import '../../../endpoints.dart';

class MyProfileController extends GetxController {
  final _dio = dio_lib.Dio();
  final Rx<UserModel?> _user = Rx<UserModel?>(null);
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  UserModel? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    fetchMyProfile();
  }

  Future<void> fetchMyProfile() async {
    try {
      isLoading.value = true;
      error.value = '';

      final registerId = AuthService.to.registerId;
      if (registerId.isEmpty) {
        error.value = 'User not logged in';
        return;
      }

      final response = await _dio.get(
        Endpoints.me(registerId),
        options: dio_lib.Options(
          headers: {'Authorization': 'Bearer ${AuthService.to.token}'},
        ),
      );

      if (response.data['success'] == true) {
        _user.value = UserModel.fromJson(response.data['data']);
      } else {
        error.value = response.data['message'] ?? 'Failed to fetch profile';
      }
    } catch (e) {
      error.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}
