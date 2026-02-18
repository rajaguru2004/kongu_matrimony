import 'package:get/get.dart';

import '../controllers/step3_controller.dart';

class Step3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Step3Controller>(
      () => Step3Controller(),
    );
  }
}
