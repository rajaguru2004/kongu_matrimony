import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import 'package:kongu_matrimony/app/utils/common_text.dart';
import 'package:kongu_matrimony/app/utils/step_widgets.dart';
import '../controllers/step6_controller.dart';

class Step6View extends GetView<Step6Controller> {
  const Step6View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildStepAppBar('About You', 6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepIndicator(6, 8),
            const SizedBox(height: 24),

            buildSectionTitle('Tell us about yourself'),
            const SizedBox(height: 6),
            CommonText(
              'Write a brief description about your personality, hobbies, and what you are looking for in a partner.',
              style: TextStyle(fontSize: 13, color: AppColors.textGrey),
            ),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: TextField(
                controller: controller.aboutYouController,
                maxLines: 8,
                minLines: 6,
                maxLength: 500,
                decoration: const InputDecoration(
                  hintText:
                      'e.g. I am a cheerful person who loves travelling and cooking. I am looking for a caring and understanding partner...',
                  hintStyle: TextStyle(
                    color: AppColors.textLight,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 32),
            buildNextButton(controller.isLoading, controller.submitStep6),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
