import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import 'package:kongu_matrimony/app/utils/common_text.dart';

AppBar buildStepAppBar(String title, int step) {
  return AppBar(
    backgroundColor: AppColors.white,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios_new, color: AppColors.textDark, size: 20),
      onPressed: () => Get.back(),
    ),
    title: CommonText(
      title,
      style: const TextStyle(
        color: AppColors.textDark,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(3),
      child: LinearProgressIndicator(
        value: step / 8,
        backgroundColor: AppColors.border,
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
        minHeight: 3,
      ),
    ),
  );
}

Widget buildStepIndicator(int current, int total) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(20),
        ),
        child: CommonText(
          'Step $current of $total',
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    ],
  );
}

Widget buildSectionTitle(String title) {
  return CommonText(
    title,
    style: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: AppColors.textDark,
    ),
  );
}

Widget buildStepTextField({
  required TextEditingController controller,
  required String label,
  required String hint,
  required IconData icon,
  TextInputType keyboardType = TextInputType.text,
  int? maxLines,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonText(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
      const SizedBox(height: 6),
      TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.textLight, fontSize: 14),
          prefixIcon: (maxLines == null || maxLines == 1)
              ? Icon(icon, color: AppColors.primary, size: 20)
              : null,
          filled: true,
          fillColor: AppColors.white,
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
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    ],
  );
}

Widget buildPickerTile({
  required String label,
  required String value,
  required IconData icon,
  required bool hasValue,
  required VoidCallback onTap,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonText(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
      const SizedBox(height: 6),
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: hasValue ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: hasValue ? AppColors.primary : AppColors.textGrey,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CommonText(
                  value,
                  style: TextStyle(
                    color: hasValue ? AppColors.textDark : AppColors.textLight,
                    fontSize: 14,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textGrey),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget buildStepDropdown({
  required String label,
  required String value,
  required List<String> options,
  required ValueChanged<String?> onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonText(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
      const SizedBox(height: 6),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.primary,
            ),
            style: const TextStyle(color: AppColors.textDark, fontSize: 14),
            items: options
                .map(
                  (opt) => DropdownMenuItem(value: opt, child: CommonText(opt)),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    ],
  );
}

Widget buildNextButton(
  RxBool isLoading,
  VoidCallback onPressed, {
  String label = 'Next',
}) {
  return Obx(
    () => SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading.value ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 3,
          shadowColor: AppColors.primary.withOpacity(0.4),
        ),
        child: isLoading.value
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2.5,
                ),
              )
            : CommonText(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    ),
  );
}

Widget buildDashedImagePicker({
  required String label,
  required String path,
  required VoidCallback onTap,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonText(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
      const SizedBox(height: 6),
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.border,
              width: 1,
              style: BorderStyle
                  .solid, // Note: Flutter doesn't natively support dashed borders easily without a package or custom painter. I'll use a specific style to mimic it or just a clean border for now if I can't find a quick way.
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (path.isEmpty) ...[
                const Icon(
                  Icons.file_upload_outlined,
                  color: AppColors.textGrey,
                  size: 28,
                ),
                const SizedBox(height: 8),
                CommonText(
                  'Choose file or drag here',
                  style: TextStyle(color: AppColors.textGrey, fontSize: 13),
                ),
              ] else ...[
                const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.primary,
                  size: 28,
                ),
                const SizedBox(height: 8),
                CommonText(
                  'File selected',
                  style: TextStyle(color: AppColors.primary, fontSize: 13),
                ),
              ],
            ],
          ),
        ),
      ),
      const SizedBox(height: 4),
      CommonText(
        'Supported: JPG, PNG, PDF (Max 5MB)',
        style: TextStyle(
          fontSize: 10,
          color: AppColors.textGrey,
          fontStyle: FontStyle.italic,
        ),
      ),
    ],
  );
}

Widget buildChipSelector({
  required String label,
  required String selectedValue,
  required List<String> options,
  required ValueChanged<String> onSelected,
  bool isRequired = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          CommonText(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          if (isRequired)
            const Text(' *', style: TextStyle(color: Colors.red, fontSize: 13)),
        ],
      ),
      const SizedBox(height: 10),
      Wrap(
        spacing: 12,
        runSpacing: 10,
        children: options.map((option) {
          final isSelected = selectedValue == option;
          return GestureDetector(
            onTap: () => onSelected(option),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: CommonText(
                option,
                style: TextStyle(
                  color: isSelected ? AppColors.primary : AppColors.textGrey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ],
  );
}
