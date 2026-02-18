import 'package:get/get.dart';

import '../controllers/step8_controller.dart';

class Step8Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Step8Controller>(
      () => Step8Controller(),
    );
  }
}
