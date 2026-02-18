import 'package:get/get.dart';

import '../controllers/initial_sign_controller.dart';

class InitialSignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InitialSignController>(
      () => InitialSignController(),
    );
  }
}
