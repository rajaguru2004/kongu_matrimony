import 'package:get/get.dart';

import '../controllers/step1_controller.dart';

class Step1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Step1Controller>(
      () => Step1Controller(),
    );
  }
}
