import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import 'package:kongu_matrimony/app/utils/step_widgets.dart';
import '../controllers/step5_controller.dart';

class Step5View extends GetView<Step5Controller> {
  const Step5View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildStepAppBar('Partner Caste Preferences', 5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepIndicator(5, 8),
            const SizedBox(height: 24),

            buildSectionTitle('Caste Preferences'),
            const SizedBox(height: 12),

            buildStepTextField(
              controller: controller.partnerCasteController,
              label: 'Partner Caste',
              hint: 'e.g. Kongu Vellalar',
              icon: Icons.people_outline,
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.partnerKulamController,
              label: 'Partner Kulam / Gotra',
              hint: 'e.g. Andai Kulam',
              icon: Icons.family_restroom,
            ),

            const SizedBox(height: 24),
            buildSectionTitle('Horoscope Preference'),
            const SizedBox(height: 12),

            Obx(
              () => buildStepDropdown(
                label: 'Horoscope Match Type',
                value: controller.partnerHoroscopeType.value,
                options: controller.horoscopeOptions,
                onChanged: (v) => controller.partnerHoroscopeType.value = v!,
              ),
            ),

            const SizedBox(height: 32),
            buildNextButton(controller.isLoading, controller.submitStep5),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
