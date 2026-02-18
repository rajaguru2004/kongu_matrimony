class Endpoints {
  static const String baseUrl = "https://api.konguelitematrimony.co.in";

  // Registration
  static const String register = "$baseUrl/app/register";

  static String step1(String registerId) =>
      "$baseUrl/app/register/$registerId/step-1";

  static String step2(String registerId) =>
      "$baseUrl/app/register/$registerId/step-2";

  static String step3(String registerId) =>
      "$baseUrl/app/register/$registerId/step-3";

  static String step4(String registerId) =>
      "$baseUrl/app/register/$registerId/step-4";

  static String step5(String registerId) =>
      "$baseUrl/app/register/$registerId/step-5";

  static String step6(String registerId) =>
      "$baseUrl/app/register/$registerId/step-6";

  static String step7(String registerId) =>
      "$baseUrl/app/register/$registerId/step-7";

  static String yourCaste(String registerId) =>
      "$baseUrl/app/register/$registerId/your-caste";
}
