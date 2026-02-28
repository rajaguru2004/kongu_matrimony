import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import 'package:kongu_matrimony/app/utils/step_widgets.dart';
import '../controllers/step2_controller.dart';

class Step2View extends GetView<Step2Controller> {
  const Step2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildStepAppBar('Caste & Community', 2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepIndicator(2, 7),
            const SizedBox(height: 24),

            const Text(
              'Your Caste & Community',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A4B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tell us about your religious and community background',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            Obx(
              () => buildStepDropdown(
                label: 'Caste (Optional)',
                value: controller.caste.value.isEmpty
                    ? 'Select Caste'
                    : controller.caste.value,
                options: ['Select Caste', ...controller.casteOptions],
                onChanged: (v) =>
                    controller.caste.value = v == 'Select Caste' ? '' : v!,
              ),
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.kootamController,
              label: 'Kootam / Kulam (Optional)',
              hint: 'Enter Kootam / Kulam',
              icon: Icons.people_outline,
            ),
            const SizedBox(height: 14),

            Obx(
              () => buildStepDropdown(
                label: 'Rasi *',
                value: controller.rasi.value.isEmpty
                    ? 'Select Rasi'
                    : controller.rasi.value,
                options: ['Select Rasi', ...controller.rasiOptions],
                onChanged: (v) =>
                    controller.rasi.value = v == 'Select Rasi' ? '' : v!,
              ),
            ),
            const SizedBox(height: 14),

            Obx(
              () => buildStepDropdown(
                label: 'Star (Nakshatram) *',
                value: controller.star.value.isEmpty
                    ? 'Select Star'
                    : controller.star.value,
                options: ['Select Star', ...controller.starOptions],
                onChanged: (v) =>
                    controller.star.value = v == 'Select Star' ? '' : v!,
              ),
            ),
            const SizedBox(height: 14),

            Obx(
              () => buildDashedImagePicker(
                label: 'Horoscope File (Optional)',
                path: controller.horoscopeFilePath.value,
                onTap: () => controller.pickHoroscope(),
              ),
            ),
            const SizedBox(height: 14),

            Obx(
              () => buildStepDropdown(
                label: 'Dosham (Optional)',
                value: controller.dosham.value.isEmpty
                    ? 'Select Dosham'
                    : controller.dosham.value,
                options: ['Select Dosham', ...controller.doshamOptions],
                onChanged: (v) =>
                    controller.dosham.value = v == 'Select Dosham' ? '' : v!,
              ),
            ),

            const SizedBox(height: 32),
            buildNextButton(
              controller.isLoading,
              controller.submitStep2,
              label: 'Continue',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
