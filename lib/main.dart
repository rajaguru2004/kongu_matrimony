import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kongu_matrimony/app/data/services/auth_service.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final authService = Get.put(AuthService());
  await authService.loadAuthData(); // Wait for stored token to load

  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),
      initialRoute: authService.isAuthenticated
          ? Routes.MAIN
          : AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
