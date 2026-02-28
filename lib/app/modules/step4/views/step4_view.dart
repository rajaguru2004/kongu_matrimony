import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import 'package:kongu_matrimony/app/utils/step_widgets.dart';
import '../controllers/step4_controller.dart';

class Step4View extends GetView<Step4Controller> {
  const Step4View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildStepAppBar('Professional Info', 4),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepIndicator(4, 7),
            const SizedBox(height: 24),

            const Text(
              "Professional details help's to find the best companion",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A4B),
              ),
            ),
            const SizedBox(height: 24),

            buildStepTextField(
              controller: controller.highestEducationController,
              label: 'Highest Education *',
              hint: 'Select Education',
              icon: Icons.school_outlined,
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.additionalDegreeController,
              label: 'Additional Degree',
              hint: 'Select Degree',
              icon: Icons.history_edu_outlined,
            ),
            const SizedBox(height: 24),

            Obx(
              () => buildChipSelector(
                label: 'Employed in',
                selectedValue: controller.employedIn.value,
                options: controller.employedInOptions,
                onSelected: (v) => controller.employedIn.value = v,
                isRequired: true,
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: buildStepTextField(
                    controller: controller.fatherNameController,
                    label: "Father's Name",
                    hint: "Enter father's name",
                    icon: Icons.person_outline,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: buildStepTextField(
                    controller: controller.motherNameController,
                    label: "Mother's Name",
                    hint: "Enter mother's name",
                    icon: Icons.person_outline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => buildStepDropdown(
                      label: "Father's Occupation",
                      value: controller.fatherOccupation.value.isEmpty
                          ? 'Select'
                          : controller.fatherOccupation.value,
                      options: ['Select', ...controller.occupationOptions],
                      onChanged: (v) => controller.fatherOccupation.value =
                          v == 'Select' ? '' : v!,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(
                    () => buildStepDropdown(
                      label: "Mother's Occupation",
                      value: controller.motherOccupation.value.isEmpty
                          ? 'Select'
                          : controller.motherOccupation.value,
                      options: ['Select', ...controller.occupationOptions],
                      onChanged: (v) => controller.motherOccupation.value =
                          v == 'Select' ? '' : v!,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            Obx(
              () => buildStepDropdown(
                label: 'Occupation *',
                value: controller.occupation.value.isEmpty
                    ? 'Select'
                    : controller.occupation.value,
                options: ['Select', ...controller.occupationOptions],
                onChanged: (v) =>
                    controller.occupation.value = v == 'Select' ? '' : v!,
              ),
            ),
            const SizedBox(height: 14),

            Obx(
              () => buildStepDropdown(
                label: 'Annual Income *',
                value: controller.annualIncome.value.isEmpty
                    ? 'Select'
                    : controller.annualIncome.value,
                options: ['Select', ...controller.incomeOptions],
                onChanged: (v) =>
                    controller.annualIncome.value = v == 'Select' ? '' : v!,
              ),
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.workLocationController,
              label: 'Work Location *',
              hint: 'Enter City',
              icon: Icons.location_city_outlined,
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.aboutWorkController,
              label: 'About Your Work (Optional)',
              hint: 'Describe your work/business',
              icon: Icons.description_outlined,
              maxLines: 3,
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.additionalIncomeController,
              label: 'Additional Income (Optional)',
              hint: 'Enter Additional Income',
              icon: Icons.add_circle_outline,
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.familyNetWorthController,
              label: 'Family Net Worth (Optional)',
              hint: 'Enter Family Net Worth',
              icon: Icons.account_balance_wallet_outlined,
            ),

            const SizedBox(height: 40),
            buildNextButton(
              controller.isLoading,
              controller.submitStep4,
              label: 'Continue',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
