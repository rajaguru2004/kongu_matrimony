import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import 'package:kongu_matrimony/app/utils/common_text.dart';
import 'package:kongu_matrimony/app/utils/step_widgets.dart';
import '../controllers/step8_controller.dart';

class Step8View extends GetView<Step8Controller> {
  const Step8View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildStepAppBar('Profile Photo', 8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepIndicator(8, 8),
            const SizedBox(height: 32),

            Center(
              child: Column(
                children: [
                  const Text(
                    'Upload Profile Photo',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A4B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const CommonText(
                    'A clear photo helps you get more responses',
                    style: TextStyle(fontSize: 14, color: AppColors.textGrey),
                  ),
                  const SizedBox(height: 48),

                  Obx(
                    () => GestureDetector(
                      onTap: controller.pickProfilePhoto,
                      child: Stack(
                        children: [
                          Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryLight,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 4,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.2),
                                  blurRadius: 25,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: controller.profilePhotoPath.value.isNotEmpty
                                ? ClipOval(
                                    child: Image.file(
                                      File(controller.profilePhotoPath.value),
                                      fit: BoxFit.cover,
                                      width: 180,
                                      height: 180,
                                    ),
                                  )
                                : const Icon(
                                    Icons.person_add_outlined,
                                    size: 80,
                                    color: AppColors.primary,
                                  ),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.white,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.cardShadow.withOpacity(
                                      0.2,
                                    ),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: AppColors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Obx(
                    () => controller.profilePhotoPath.value.isNotEmpty
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.success,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                CommonText(
                                  'Photo uploaded successfully',
                                  style: TextStyle(
                                    color: AppColors.success,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : TextButton.icon(
                            onPressed: controller.pickProfilePhoto,
                            icon: const Icon(
                              Icons.photo_library_outlined,
                              size: 24,
                            ),
                            label: const Text(
                              'Choose from Gallery',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),
            buildNextButton(
              controller.isLoading,
              controller.submitStep8,
              label: 'Complete Registration',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
