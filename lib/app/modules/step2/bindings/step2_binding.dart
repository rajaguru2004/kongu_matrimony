import 'package:get/get.dart';

import '../controllers/step2_controller.dart';

class Step2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Step2Controller>(
      () => Step2Controller(),
    );
  }
}
