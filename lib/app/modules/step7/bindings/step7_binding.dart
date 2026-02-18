import 'package:get/get.dart';

import '../controllers/step7_controller.dart';

class Step7Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Step7Controller>(
      () => Step7Controller(),
    );
  }
}
