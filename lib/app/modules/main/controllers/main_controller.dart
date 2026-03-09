import 'package:get/get.dart';
import 'package:kongu_matrimony/app/modules/interests/controllers/interests_controller.dart';

class MainController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
    if (index == 2) {
      if (Get.isRegistered<InterestsController>()) {
        Get.find<InterestsController>().fetchInterests();
      }
    }
  }
}
