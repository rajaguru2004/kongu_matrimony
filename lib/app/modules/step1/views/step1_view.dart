import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import 'package:kongu_matrimony/app/utils/common_text.dart';
import 'package:kongu_matrimony/app/utils/step_widgets.dart';
import '../controllers/step1_controller.dart';

class Step1View extends GetView<Step1Controller> {
  const Step1View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildStepAppBar('Personal Details', 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepIndicator(1, 8),
            const SizedBox(height: 24),

            buildSectionTitle('Contact Information'),
            const SizedBox(height: 12),
            buildStepTextField(
              controller: controller.emailController,
              label: 'Email Address',
              hint: 'Enter your email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 14),
            buildStepTextField(
              controller: controller.alternatePhoneController,
              label: 'Alternate Phone (Optional)',
              hint: 'Enter alternate number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 24),
            buildSectionTitle('Date & Time of Birth'),
            const SizedBox(height: 12),

            Obx(
              () => buildPickerTile(
                label: 'Date of Birth',
                value: controller.dob.value.isEmpty
                    ? 'Select date of birth'
                    : controller.dob.value,
                icon: Icons.calendar_today_outlined,
                hasValue: controller.dob.value.isNotEmpty,
                onTap: () => controller.pickDate(context),
              ),
            ),
            const SizedBox(height: 14),

            Obx(
              () => buildPickerTile(
                label: 'Time of Birth',
                value: controller.timeOfBirth.value.isEmpty
                    ? 'Select time of birth'
                    : controller.timeOfBirth.value,
                icon: Icons.access_time_outlined,
                hasValue: controller.timeOfBirth.value.isNotEmpty,
                onTap: () => controller.pickTime(context),
              ),
            ),

            const SizedBox(height: 24),
            buildSectionTitle('Identity Documents'),
            const SizedBox(height: 4),
            CommonText(
              'Upload your identity proof (Aadhaar / PAN / Passport)',
              style: TextStyle(fontSize: 12, color: AppColors.textGrey),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => _buildImagePicker(
                      label: 'ID Proof Front',
                      path: controller.identityProofFrontPath.value,
                      onTap: () => controller.pickImage('identityFront'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(
                    () => _buildImagePicker(
                      label: 'ID Proof Back',
                      path: controller.identityProofBackPath.value,
                      onTap: () => controller.pickImage('identityBack'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            buildSectionTitle("Parent's Identity Documents"),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => _buildImagePicker(
                      label: 'Parent ID Front',
                      path: controller.parentIdentityFrontPath.value,
                      onTap: () => controller.pickImage('parentFront'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(
                    () => _buildImagePicker(
                      label: 'Parent ID Back',
                      path: controller.parentIdentityBackPath.value,
                      onTap: () => controller.pickImage('parentBack'),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
            buildNextButton(controller.isLoading, controller.submitStep1),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker({
    required String label,
    required String path,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: path.isNotEmpty ? AppColors.primary : AppColors.border,
            width: 1.5,
          ),
        ),
        child: path.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.file(
                  File(path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.upload_file_outlined,
                    color: AppColors.primary,
                    size: 28,
                  ),
                  const SizedBox(height: 6),
                  CommonText(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
