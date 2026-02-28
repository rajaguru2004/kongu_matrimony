import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import 'package:kongu_matrimony/app/utils/step_widgets.dart';
import '../controllers/step3_controller.dart';

class Step3View extends GetView<Step3Controller> {
  const Step3View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildStepAppBar('Personal Details', 3),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepIndicator(3, 7),
            const SizedBox(height: 24),

            const Text(
              'Tell us about your personal details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A4B),
              ),
            ),
            const SizedBox(height: 24),

            Obx(
              () => buildChipSelector(
                label: 'Marital Status',
                selectedValue: controller.maritalStatus.value,
                options: controller.maritalStatusOptions,
                onSelected: (v) => controller.maritalStatus.value = v,
                isRequired: true,
              ),
            ),
            const SizedBox(height: 24),

            Obx(
              () => buildStepDropdown(
                label: 'Height (Optional)',
                value: controller.height.value.isEmpty
                    ? 'Select Height'
                    : controller.height.value,
                options: ['Select Height', ...controller.heightOptions],
                onChanged: (v) =>
                    controller.height.value = v == 'Select Height' ? '' : v!,
              ),
            ),
            const SizedBox(height: 24),

            Obx(
              () => buildStepDropdown(
                label: 'Family Status (Optional)',
                value: controller.familyStatus.value.isEmpty
                    ? 'Select Family Status'
                    : controller.familyStatus.value,
                options: [
                  'Select Family Status',
                  ...controller.familyStatusOptions,
                ],
                onChanged: (v) => controller.familyStatus.value =
                    v == 'Select Family Status' ? '' : v!,
              ),
            ),
            const SizedBox(height: 24),

            Obx(
              () => buildChipSelector(
                label: 'Family Type (Optional)',
                selectedValue: controller.familyType.value,
                options: controller.familyTypeOptions,
                onSelected: (v) => controller.familyType.value = v,
              ),
            ),
            const SizedBox(height: 24),

            Obx(
              () => buildChipSelector(
                label: 'Family Values (Optional)',
                selectedValue: controller.familyValues.value,
                options: controller.familyValuesOptions,
                onSelected: (v) => controller.familyValues.value = v,
              ),
            ),
            const SizedBox(height: 24),

            Obx(
              () => buildChipSelector(
                label: 'Any Disability',
                selectedValue: controller.anyDisability.value,
                options: controller.disabilityOptions,
                onSelected: (v) => controller.anyDisability.value = v,
                isRequired: true,
              ),
            ),

            const SizedBox(height: 40),
            buildNextButton(
              controller.isLoading,
              controller.submitStep3,
              label: 'Continue',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
