import 'package:get/get.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final RxString _token = ''.obs;
  final RxString _registerId = ''.obs;

  String get token => _token.value;
  String get registerId => _registerId.value;

  bool get isAuthenticated => _token.value.isNotEmpty;

  void login(String token, String registerId) {
    _token.value = token;
    _registerId.value = registerId;
  }

  void logout() {
    _token.value = '';
    _registerId.value = '';
  }
}
