import 'package:get/get.dart';

import '../controllers/step6_controller.dart';

class Step6Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Step6Controller>(
      () => Step6Controller(),
    );
  }
}
