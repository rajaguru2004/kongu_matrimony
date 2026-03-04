import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  final _storage = const FlutterSecureStorage();

  final RxString _token = ''.obs;
  final RxString _registerId = ''.obs;

  String get token => _token.value;
  String get registerId => _registerId.value;

  bool get isAuthenticated => _token.value.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    loadAuthData();
  }

  Future<void> login(String token, String registerId) async {
    _token.value = token;
    _registerId.value = registerId;
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'registerId', value: registerId);
  }

  Future<void> loadAuthData() async {
    _token.value = await _storage.read(key: 'token') ?? '';
    _registerId.value = await _storage.read(key: 'registerId') ?? '';
  }

  Future<void> logout() async {
    _token.value = '';
    _registerId.value = '';
    await _storage.deleteAll();
  }
}
