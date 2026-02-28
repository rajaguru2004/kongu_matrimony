import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import 'package:kongu_matrimony/app/utils/step_widgets.dart';
import '../controllers/step6_controller.dart';

class Step6View extends GetView<Step6Controller> {
  const Step6View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildStepAppBar('Partner Religious Info', 6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepIndicator(6, 7),
            const SizedBox(height: 24),

            const Text(
              "Religious preferences help's to find the best companion",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A4B),
              ),
            ),
            const SizedBox(height: 24),

            Obx(
              () => buildStepDropdown(
                label: 'Partner Caste',
                value: controller.partnerCaste.value,
                options: ['Any', 'Kongu Vellalar'],
                onChanged: (v) => controller.partnerCaste.value = v!,
              ),
            ),
            const SizedBox(height: 14),

            buildStepTextField(
              controller: TextEditingController(
                text: controller.partnerKootam.value == 'Any'
                    ? ''
                    : controller.partnerKootam.value,
              ),
              label: 'Partner Kulam',
              hint: 'e.g. Porulanthai',
              icon: Icons.group_outlined,
            ),
            const SizedBox(height: 14),

            Obx(
              () => buildStepDropdown(
                label: 'Partner Star',
                value: controller.partnerStar.value,
                options: controller.starOptions,
                onChanged: (v) => controller.partnerStar.value = v!,
              ),
            ),
            const SizedBox(height: 14),

            Obx(
              () => buildStepDropdown(
                label: 'Partner Rasi',
                value: controller.partnerRasi.value,
                options: controller.rasiOptions,
                onChanged: (v) => controller.partnerRasi.value = v!,
              ),
            ),
            const SizedBox(height: 24),

            Obx(
              () => buildChipSelector(
                label: 'Partner Dosham',
                selectedValue: controller.partnerDosham.value,
                options: ['No', 'Yes', 'Any'],
                onSelected: (v) => controller.partnerDosham.value = v,
                isRequired: true,
              ),
            ),

            const SizedBox(height: 40),
            buildNextButton(
              controller.isLoading,
              controller.submitStep6,
              label: 'Continue',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
