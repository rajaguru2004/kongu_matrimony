import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import 'package:kongu_matrimony/app/utils/common_text.dart';
import 'package:kongu_matrimony/app/utils/step_widgets.dart';
import '../controllers/step8_controller.dart';

class Step8View extends GetView<Step8Controller> {
  const Step8View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildStepAppBar('Your Caste & Horoscope', 8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepIndicator(8, 8),
            const SizedBox(height: 24),

            buildSectionTitle('Caste Details'),
            const SizedBox(height: 12),

            buildStepTextField(
              controller: controller.yourCasteController,
              label: 'Your Caste',
              hint: 'e.g. Kongu Vellala Gounder',
              icon: Icons.people_outline,
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.yourKootamController,
              label: 'Your Kootam / Kulam',
              hint: 'e.g. Aandhai Kootam',
              icon: Icons.family_restroom,
            ),

            const SizedBox(height: 24),
            buildSectionTitle('Horoscope Details'),
            const SizedBox(height: 12),

            Obx(
              () => buildStepDropdown(
                label: 'Dosham',
                value: controller.yourDosham.value,
                options: controller.doshamOptions,
                onChanged: (v) => controller.yourDosham.value = v!,
              ),
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.yourStarController,
              label: 'Your Star (Natchathiram)',
              hint: 'e.g. Rohini',
              icon: Icons.star_outline,
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.yourRasiController,
              label: 'Your Rasi',
              hint: 'e.g. Rishabam',
              icon: Icons.brightness_3_outlined,
            ),

            const SizedBox(height: 32),

            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.submitStep8,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 3,
                    shadowColor: AppColors.primary.withOpacity(0.4),
                  ),
                  child: controller.isLoading.value
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_outline, size: 20),
                            SizedBox(width: 8),
                            CommonText(
                              'Complete Registration',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
