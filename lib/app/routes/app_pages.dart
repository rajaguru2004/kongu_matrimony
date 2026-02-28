import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/initial_sign/bindings/initial_sign_binding.dart';
import '../modules/initial_sign/views/initial_sign_view.dart';
import '../modules/step1/bindings/step1_binding.dart';
import '../modules/step1/views/step1_view.dart';
import '../modules/step2/bindings/step2_binding.dart';
import '../modules/step2/views/step2_view.dart';
import '../modules/step3/bindings/step3_binding.dart';
import '../modules/step3/views/step3_view.dart';
import '../modules/step4/bindings/step4_binding.dart';
import '../modules/step4/views/step4_view.dart';
import '../modules/step5/bindings/step5_binding.dart';
import '../modules/step5/views/step5_view.dart';
import '../modules/step6/bindings/step6_binding.dart';
import '../modules/step6/views/step6_view.dart';
import '../modules/step7/bindings/step7_binding.dart';
import '../modules/step7/views/step7_view.dart';
import '../modules/step8/bindings/step8_binding.dart';
import '../modules/step8/views/step8_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INITIAL_SIGN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INITIAL_SIGN,
      page: () => const InitialSignView(),
      binding: InitialSignBinding(),
    ),
    GetPage(
      name: _Paths.STEP1,
      page: () => const Step1View(),
      binding: Step1Binding(),
    ),
    GetPage(
      name: _Paths.STEP2,
      page: () => const Step2View(),
      binding: Step2Binding(),
    ),
    GetPage(
      name: _Paths.STEP3,
      page: () => const Step3View(),
      binding: Step3Binding(),
    ),
    GetPage(
      name: _Paths.STEP4,
      page: () => const Step4View(),
      binding: Step4Binding(),
    ),
    GetPage(
      name: _Paths.STEP5,
      page: () => const Step5View(),
      binding: Step5Binding(),
    ),
    GetPage(
      name: _Paths.STEP6,
      page: () => const Step6View(),
      binding: Step6Binding(),
    ),
    GetPage(
      name: _Paths.STEP7,
      page: () => const Step7View(),
      binding: Step7Binding(),
    ),
    GetPage(
      name: _Paths.STEP8,
      page: () => const Step8View(),
      binding: Step8Binding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
  ];
}
