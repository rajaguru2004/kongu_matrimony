import 'package:get/get.dart';

import '../controllers/step4_controller.dart';

class Step4Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Step4Controller>(
      () => Step4Controller(),
    );
  }
}
