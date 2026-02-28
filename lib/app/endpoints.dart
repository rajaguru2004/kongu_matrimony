class Endpoints {
  static const String baseUrl = "https://api.konguelitematrimony.co.in";
  static const String uploadImage = "$baseUrl/website/image/upload";

  // Registration
  static const String registerBase = "$baseUrl/website/auth/register";
  static const String sendOtp = "$registerBase/otp/send";
  static const String verifyOtp = "$registerBase/otp/verify";
  static const String register = "$baseUrl/app/register";

  static String step1(String registerId) => "$registerBase/$registerId/step-1";

  static String yourCaste(String registerId) =>
      "$registerBase/$registerId/your-caste";

  static String step2(String registerId) => "$registerBase/$registerId/step-2";

  static String step3(String registerId) => "$registerBase/$registerId/step-3";

  static String step4(String registerId) => "$registerBase/$registerId/step-4";

  static String step5(String registerId) => "$registerBase/$registerId/step-5";

  static String step6(String registerId) => "$registerBase/$registerId/step-6";

  static String step7(String registerId) => "$registerBase/$registerId/step-7";
}
