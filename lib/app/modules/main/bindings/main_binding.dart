import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../matches/controllers/matches_controller.dart';

import 'package:kongu_matrimony/app/modules/interests/controllers/interests_controller.dart';
import '../../my_profile/controllers/my_profile_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MatchesController>(() => MatchesController());
    Get.lazyPut<InterestsController>(() => InterestsController());
    Get.lazyPut<MyProfileController>(() => MyProfileController());
  }
}
