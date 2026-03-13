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
      appBar: buildStepAppBar('Partner Basic Info', 5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepIndicator(5, 7),
            const SizedBox(height: 24),

            const Text(
              "Partner preferences help's to find the best companion",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),

            buildSectionTitle('Partner Preferences'),
            const SizedBox(height: 12),

            Obx(
              () => buildStepDropdown(
                label: 'Marital Status',
                value: controller.partnerMaritalStatus.value,
                options: controller.maritalStatusOptions,
                onChanged: (v) => controller.partnerMaritalStatus.value = v!,
              ),
            ),
            const SizedBox(height: 14),

            Obx(
              () => buildStepDropdown(
                label: 'Partner Education',
                value: controller.partnerEducation.value.isEmpty
                    ? 'Select Education'
                    : controller.partnerEducation.value,
                options: ['Select Education', ...controller.educationOptions],
                onChanged: (v) => controller.partnerEducation.value =
                    v == 'Select Education' ? '' : v!,
              ),
            ),
            const SizedBox(height: 14),

            Obx(
              () => buildStepDropdown(
                label: 'Partner Profession',
                value: controller.partnerProfession.value.isEmpty
                    ? 'Select Occupation'
                    : controller.partnerProfession.value,
                options: ['Select Occupation', ...controller.occupationOptions],
                onChanged: (v) => controller.partnerProfession.value =
                    v == 'Select Occupation' ? '' : v!,
              ),
            ),
            const SizedBox(height: 14),

            Obx(
              () => buildStepDropdown(
                label: 'Partner Annual Income',
                value: controller.partnerAnnualIncome.value.isEmpty
                    ? 'Select Income'
                    : controller.partnerAnnualIncome.value,
                options: ['Select Income', ...controller.incomeOptions],
                onChanged: (v) => controller.partnerAnnualIncome.value =
                    v == 'Select Income' ? '' : v!,
              ),
            ),

            const SizedBox(height: 40),
            buildNextButton(
              controller.isLoading,
              controller.submitStep5,
              label: 'Continue',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
