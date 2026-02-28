import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/user_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/data/services/auth_service.dart';

class HomeController extends GetxController {
  final _api = ApiService();
  final _auth = AuthService.to;

  final RxList<UserModel> matches = <UserModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMatches();
  }

  Future<void> fetchMatches() async {
    if (!_auth.isAuthenticated) return;

    isLoading.value = true;
    final result = await _api.getMatches(
      registerId: _auth.registerId,
      token: _auth.token,
    );
    matches.assignAll(result);
    isLoading.value = false;
  }
}
