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
      appBar: buildStepAppBar('Family & Personal Info', 2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepIndicator(2, 8),
            const SizedBox(height: 24),

            buildSectionTitle('Personal Details'),
            const SizedBox(height: 12),

            Obx(
              () => buildStepDropdown(
                label: 'Marital Status',
                value: controller.maritalStatus.value,
                options: controller.maritalStatusOptions,
                onChanged: (v) => controller.maritalStatus.value = v!,
              ),
            ),
            const SizedBox(height: 14),

            Obx(
              () => buildStepDropdown(
                label: 'Height',
                value: controller.height.value,
                options: controller.heightOptions,
                onChanged: (v) => controller.height.value = v!,
              ),
            ),
            const SizedBox(height: 14),

            Obx(
              () => buildStepDropdown(
                label: 'Any Disability',
                value: controller.anyDisability.value,
                options: controller.disabilityOptions,
                onChanged: (v) => controller.anyDisability.value = v!,
              ),
            ),

            const SizedBox(height: 24),
            buildSectionTitle('Family Details'),
            const SizedBox(height: 12),

            Obx(
              () => buildStepDropdown(
                label: 'Family Status',
                value: controller.familyStatus.value,
                options: controller.familyStatusOptions,
                onChanged: (v) => controller.familyStatus.value = v!,
              ),
            ),
            const SizedBox(height: 14),

            Obx(
              () => buildStepDropdown(
                label: 'Family Type',
                value: controller.familyType.value,
                options: controller.familyTypeOptions,
                onChanged: (v) => controller.familyType.value = v!,
              ),
            ),
            const SizedBox(height: 14),

            Obx(
              () => buildStepDropdown(
                label: 'Family Values',
                value: controller.familyValues.value,
                options: controller.familyValuesOptions,
                onChanged: (v) => controller.familyValues.value = v!,
              ),
            ),

            const SizedBox(height: 32),
            buildNextButton(controller.isLoading, controller.submitStep2),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
