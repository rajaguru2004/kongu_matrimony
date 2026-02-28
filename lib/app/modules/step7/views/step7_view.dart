import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import 'package:kongu_matrimony/app/utils/common_text.dart';
import 'package:kongu_matrimony/app/utils/step_widgets.dart';
import '../controllers/step7_controller.dart';

class Step7View extends GetView<Step7Controller> {
  const Step7View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildStepAppBar('Profile Photo', 7),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepIndicator(7, 8),
            const SizedBox(height: 32),

            Center(
              child: Column(
                children: [
                  CommonText(
                    'Upload Profile Photo',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const CommonText(
                    'A clear photo helps you get more responses',
                    style: TextStyle(fontSize: 13, color: AppColors.textGrey),
                  ),
                  const SizedBox(height: 32),

                  Obx(
                    () => GestureDetector(
                      onTap: controller.pickProfilePhoto,
                      child: Stack(
                        children: [
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryLight,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: controller.profilePhotoPath.value.isNotEmpty
                                ? ClipOval(
                                    child: Image.file(
                                      File(controller.profilePhotoPath.value),
                                      fit: BoxFit.cover,
                                      width: 160,
                                      height: 160,
                                    ),
                                  )
                                : const Icon(
                                    Icons.person,
                                    size: 80,
                                    color: AppColors.primary,
                                  ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: AppColors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Obx(
                    () => controller.profilePhotoPath.value.isNotEmpty
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.success,
                                  size: 16,
                                ),
                                SizedBox(width: 6),
                                CommonText(
                                  'Photo selected',
                                  style: TextStyle(
                                    color: AppColors.success,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : TextButton.icon(
                            onPressed: controller.pickProfilePhoto,
                            icon: const Icon(
                              Icons.photo_library_outlined,
                              color: AppColors.primary,
                            ),
                            label: const CommonText(
                              'Choose from Gallery',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            buildNextButton(controller.isLoading, controller.submitStep7),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () => Get.toNamed(
                  Routes.STEP8,
                  arguments: controller.registerModel,
                ),
                child: const CommonText(
                  'Skip for now',
                  style: TextStyle(color: AppColors.textGrey),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
