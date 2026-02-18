import 'package:get/get.dart';

import '../controllers/step5_controller.dart';

class Step5Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Step5Controller>(
      () => Step5Controller(),
    );
  }
}
