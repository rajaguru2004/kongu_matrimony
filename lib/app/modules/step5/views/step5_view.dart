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
                color: Color(0xFF1A1A4B),
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

            buildStepTextField(
              controller: controller.partnerEducationController,
              label: 'Education',
              hint: "e.g. Bachelor's Degree",
              icon: Icons.school_outlined,
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.partnerProfessionController,
              label: 'Profession',
              hint: 'e.g. Software Engineer',
              icon: Icons.work_outline,
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.partnerAnnualIncomeController,
              label: 'Annual Income',
              hint: 'e.g. 6,00,000 INR',
              icon: Icons.currency_rupee,
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
