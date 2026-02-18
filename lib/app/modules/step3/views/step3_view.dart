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
      appBar: buildStepAppBar('Education & Career', 3),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepIndicator(3, 8),
            const SizedBox(height: 24),

            buildSectionTitle('Education'),
            const SizedBox(height: 12),

            buildStepTextField(
              controller: controller.highestEducationController,
              label: 'Highest Education',
              hint: 'e.g. Bachelor of Engineering',
              icon: Icons.school_outlined,
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.additionalDegreeController,
              label: 'Additional Degree (Optional)',
              hint: 'e.g. MBA, M.Tech',
              icon: Icons.menu_book_outlined,
            ),

            const SizedBox(height: 24),
            buildSectionTitle('Career'),
            const SizedBox(height: 12),

            Obx(
              () => buildStepDropdown(
                label: 'Employed In',
                value: controller.employedIn.value,
                options: controller.employedInOptions,
                onChanged: (v) => controller.employedIn.value = v!,
              ),
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.occupationController,
              label: 'Occupation',
              hint: 'e.g. Software Engineer',
              icon: Icons.work_outline,
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.professionController,
              label: 'Profession',
              hint: 'e.g. IT Professional',
              icon: Icons.badge_outlined,
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.workLocationController,
              label: 'Work Location',
              hint: 'e.g. Chennai, Tamil Nadu',
              icon: Icons.location_on_outlined,
            ),

            const SizedBox(height: 24),
            buildSectionTitle('Income & Net Worth'),
            const SizedBox(height: 12),

            buildStepTextField(
              controller: controller.annualIncomeController,
              label: 'Annual Income',
              hint: 'e.g. 8,00,000 INR',
              icon: Icons.currency_rupee,
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.additionalIncomeController,
              label: 'Additional Income (Optional)',
              hint: 'e.g. Freelancing - 1,00,000 INR',
              icon: Icons.add_chart,
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: controller.familyNetWorthController,
              label: 'Family Net Worth (Optional)',
              hint: 'e.g. 50,00,000 INR',
              icon: Icons.account_balance_outlined,
            ),

            const SizedBox(height: 32),
            buildNextButton(controller.isLoading, controller.submitStep3),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
