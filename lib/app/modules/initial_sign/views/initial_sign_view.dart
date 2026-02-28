import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import 'package:kongu_matrimony/app/utils/common_text.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';
import '../controllers/initial_sign_controller.dart';

class InitialSignView extends GetView<InitialSignController> {
  const InitialSignView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                  24,
                  isSmallScreen ? 24 : 32,
                  24,
                  isSmallScreen ? 32 : 40,
                ),
                child: Column(
                  children: [
                    Container(
                      width: isSmallScreen ? 60 : 72,
                      height: isSmallScreen ? 60 : 72,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.primary,
                        size: isSmallScreen ? 30 : 36,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 12 : 16),
                    CommonText(
                      'Kongu Matrimony',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: isSmallScreen ? 20 : 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    CommonText(
                      'Find your perfect life partner',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: isSmallScreen ? 12 : 14,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      'Create Profile',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 18 : 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    CommonText(
                      'Tell us about yourself to get started',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 12 : 14,
                        color: AppColors.textGrey,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 16 : 24),

                    // Profile For
                    const CommonText(
                      'Profile For',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: controller.profileForOptions.map((opt) {
                          final isSelected =
                              controller.profileFor.value == opt['value'];
                          return GestureDetector(
                            onTap: () =>
                                controller.profileFor.value = opt['value']!,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 12 : 16,
                                vertical: isSmallScreen ? 8 : 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.border,
                                  width: 1.5,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: AppColors.primary.withOpacity(
                                            0.3,
                                          ),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : [],
                              ),
                              child: CommonText(
                                opt['label']!,
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColors.white
                                      : AppColors.textDark,
                                  fontWeight: FontWeight.w500,
                                  fontSize: isSmallScreen ? 12 : 13,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? 12 : 20),

                    // Name field
                    _buildTextField(
                      controller: controller.nameController,
                      label: 'Full Name',
                      hint: 'Enter your full name',
                      icon: Icons.person_outline,
                      isSmallScreen: isSmallScreen,
                    ),
                    SizedBox(height: isSmallScreen ? 12 : 16),

                    // Phone field
                    _buildTextField(
                      controller: controller.phoneController,
                      label: 'Mobile Number',
                      hint: 'Enter 10-digit mobile number',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      isSmallScreen: isSmallScreen,
                    ),
                    SizedBox(height: isSmallScreen ? 12 : 20),

                    // Gender
                    const CommonText(
                      'Gender',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => Row(
                        children: [
                          _buildGenderChip(
                            label: 'Male',
                            icon: Icons.male,
                            value: 'male',
                            selected: controller.gender.value == 'male',
                            onTap: () => controller.gender.value = 'male',
                            isSmallScreen: isSmallScreen,
                          ),
                          const SizedBox(width: 12),
                          _buildGenderChip(
                            label: 'Female',
                            icon: Icons.female,
                            value: 'female',
                            selected: controller.gender.value == 'female',
                            onTap: () => controller.gender.value = 'female',
                            isSmallScreen: isSmallScreen,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? 20 : 32),

                    // Next Button
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: isSmallScreen ? 48 : 52,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            disabledBackgroundColor: AppColors.primary
                                .withOpacity(0.6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 3,
                            shadowColor: AppColors.primary.withOpacity(0.4),
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : CommonText(
                                  'Next',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 15 : 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                        ),
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? 8 : 16),
                    Center(
                      child: TextButton(
                        onPressed: () => Get.toNamed(Routes.LOGIN),
                        child: CommonText(
                          'Already registered? Login',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: isSmallScreen ? 13 : 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    bool isSmallScreen = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          label,
          style: TextStyle(
            fontSize: isSmallScreen ? 13 : 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: isSmallScreen ? 6 : 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLength: maxLength,
          style: TextStyle(fontSize: isSmallScreen ? 14 : 15),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.textLight,
              fontSize: isSmallScreen ? 13 : 14,
            ),
            prefixIcon: Icon(
              icon,
              color: AppColors.primary,
              size: isSmallScreen ? 18 : 20,
            ),
            filled: true,
            fillColor: AppColors.white,
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: isSmallScreen ? 12 : 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderChip({
    required String label,
    required IconData icon,
    required String value,
    required bool selected,
    required VoidCallback onTap,
    bool isSmallScreen = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 10 : 14),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: selected ? AppColors.white : AppColors.textGrey,
                size: isSmallScreen ? 18 : 20,
              ),
              SizedBox(width: isSmallScreen ? 4 : 6),
              CommonText(
                label,
                style: TextStyle(
                  color: selected ? AppColors.white : AppColors.textDark,
                  fontWeight: FontWeight.w600,
                  fontSize: isSmallScreen ? 13 : 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
