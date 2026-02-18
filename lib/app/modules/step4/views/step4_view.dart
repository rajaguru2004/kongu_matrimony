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
      appBar: buildStepAppBar('Partner Preferences', 4),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepIndicator(4, 8),
            const SizedBox(height: 24),

            buildSectionTitle('Age Preference'),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Age Range',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${controller.partnerMinAge.value} - ${controller.partnerMaxAge.value} yrs',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => RangeSlider(
                      values: RangeValues(
                        controller.partnerMinAge.value.toDouble(),
                        controller.partnerMaxAge.value.toDouble(),
                      ),
                      min: 18,
                      max: 60,
                      divisions: 42,
                      activeColor: AppColors.primary,
                      inactiveColor: AppColors.border,
                      labels: RangeLabels(
                        '${controller.partnerMinAge.value}',
                        '${controller.partnerMaxAge.value}',
                      ),
                      onChanged: (values) {
                        controller.partnerMinAge.value = values.start.round();
                        controller.partnerMaxAge.value = values.end.round();
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            buildSectionTitle('Partner Details'),
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
              controller: controller.partnerJobLocationController,
              label: 'Job Location',
              hint: 'e.g. Chennai',
              icon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.partnerAnnualIncomeController,
              label: 'Annual Income',
              hint: 'e.g. 6,00,000 INR',
              icon: Icons.currency_rupee,
            ),

            const SizedBox(height: 32),
            buildNextButton(controller.isLoading, controller.submitStep4),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
