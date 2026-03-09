import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/user_model.dart';
import 'package:kongu_matrimony/app/data/models/filter_model.dart';
import 'package:kongu_matrimony/app/routes/app_pages.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import 'package:kongu_matrimony/app/utils/common_text.dart';
import '../controllers/matches_controller.dart';

// Theme colors are now centralized in AppColors

class MatchesView extends GetView<MatchesController> {
  const MatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Obx(
          () => CommonText(
            controller.title.value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryDark, AppColors.primary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _showFilterBottomSheet(context),
            icon: const Icon(Icons.tune_rounded, color: Colors.white),
          ),
          IconButton(
            onPressed: () => controller.toggleView(),
            icon: Obx(
              () => Icon(
                controller.isSwipeMode.value
                    ? Icons.grid_view_rounded
                    : Icons.style_rounded,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (controller.profiles.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_search_rounded,
                  size: 80,
                  color: AppColors.primary.withOpacity(0.2),
                ),
                const SizedBox(height: 16),
                const CommonText(
                  'No profiles found for this section.',
                  style: TextStyle(color: AppColors.textGrey, fontSize: 16),
                ),
              ],
            ),
          );
        }

        return controller.isSwipeMode.value
            ? _buildSwipeView()
            : _buildGridView();
      }),
    );
  }

  Widget _buildGridView() {
    return RefreshIndicator(
      onRefresh: () => controller.fetchProfiles(),
      color: AppColors.primary,
      child: ListView(
        controller: controller.scrollController,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: controller.profiles.length,
            itemBuilder: (context, index) {
              return _MatchGridCard(match: controller.profiles[index]);
            },
          ),
          Obx(() {
            if (controller.isMoreLoading.value) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              );
            }
            return const SizedBox(height: 20);
          }),
        ],
      ),
    );
  }

  Widget _buildSwipeView() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            child: Obx(
              () => CardSwiper(
                controller: controller.swiperController,
                cardsCount: controller.profiles.length,
                onSwipe: controller.onSwipe,
                numberOfCardsDisplayed: controller.profiles.length > 3
                    ? 3
                    : controller.profiles.length,
                backCardOffset: const Offset(0, 40),
                padding: const EdgeInsets.only(bottom: 20),
                cardBuilder:
                    (
                      context,
                      index,
                      horizontalThresholdPercentage,
                      verticalThresholdPercentage,
                    ) {
                      return _TinderMatchCard(
                        match: controller.profiles[index],
                      );
                    },
              ),
            ),
          ),
        ),
        _buildActionButtons(),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _CircleButton(
            onPressed: () => controller.swipeLeft(),
            icon: Icons.close_rounded,
            color: const Color(0xFFFF4B4B), // Red for X
            size: 70,
          ),
          _CircleButton(
            onPressed: () => controller.swipeRight(),
            icon: Icons.favorite_rounded,
            color: const Color(0xFF2ECC71), // Green for Heart
            size: 70,
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final minAge = RxInt(controller.activeFilter.value?.minAge ?? 18);
    final maxAge = RxInt(controller.activeFilter.value?.maxAge ?? 60);
    final annualIncome = RxString(
      controller.activeFilter.value?.annualIncome ?? 'Any',
    );
    final familyNetWorth = RxString(
      controller.activeFilter.value?.familyNetWorth ?? 'Any',
    );
    final education = RxString(
      controller.activeFilter.value?.education ?? 'Any',
    );
    final highestEducation = RxString(
      controller.activeFilter.value?.highestEducation ?? 'Any',
    );
    final occupation = RxString(
      controller.activeFilter.value?.occupation ?? 'Any',
    );
    final dosham = RxString(controller.activeFilter.value?.dosham ?? 'Any');
    final caste = RxString(controller.activeFilter.value?.caste ?? 'Any');
    final maritalStatus = RxString(
      controller.activeFilter.value?.maritalStatus ?? 'Any',
    );
    final workCountry = RxString(
      controller.activeFilter.value?.workCountry ?? 'Any',
    );

    final ageOptions = List.generate(43, (index) => (index + 18).toString());

    Get.bottomSheet(
      Container(
        height: Get.height * 0.8,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CommonText(
                    'Filters',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => controller.resetFilters(),
                    child: const CommonText(
                      'Reset All',
                      style: TextStyle(color: AppColors.primary, fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Age Range
              _buildFilterLabel(Icons.star_border_rounded, 'AGE RANGE'),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => _buildDropdown(
                        value: minAge.value.toString(),
                        items: ageOptions,
                        onChanged: (v) => minAge.value = int.parse(v!),
                        hint: 'Min',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Obx(
                      () => _buildDropdown(
                        value: maxAge.value.toString(),
                        items: ageOptions,
                        onChanged: (v) => maxAge.value = int.parse(v!),
                        hint: 'Max',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Annual Income
              _buildFilterLabel(
                Icons.account_balance_wallet_outlined,
                'ANNUAL INCOME',
              ),
              Obx(
                () => _buildDropdown(
                  value: annualIncome.value,
                  items: controller.incomeOptions,
                  onChanged: (v) => annualIncome.value = v!,
                ),
              ),
              const SizedBox(height: 20),

              // Family Net Worth
              _buildFilterLabel(
                Icons.currency_rupee_rounded,
                'FAMILY NET WORTH',
              ),
              Obx(
                () => _buildDropdown(
                  value: familyNetWorth.value,
                  items: controller.incomeOptions,
                  onChanged: (v) => familyNetWorth.value = v!,
                ),
              ),
              const SizedBox(height: 20),

              // Education
              _buildFilterLabel(Icons.school_outlined, 'EDUCATION'),
              Obx(
                () => _buildDropdown(
                  value: education.value,
                  items: ['Any', ...controller.educations.map((e) => e.name)],
                  onChanged: (v) => education.value = v!,
                ),
              ),
              const SizedBox(height: 20),

              // Highest Education
              _buildFilterLabel(
                Icons.workspace_premium_outlined,
                'HIGHEST EDUCATION',
              ),
              Obx(
                () => _buildDropdown(
                  value: highestEducation.value,
                  items: ['Any', ...controller.educations.map((e) => e.name)],
                  onChanged: (v) => highestEducation.value = v!,
                ),
              ),
              const SizedBox(height: 20),

              // Occupation
              _buildFilterLabel(Icons.card_travel_rounded, 'OCCUPATION'),
              Obx(
                () => _buildDropdown(
                  value: occupation.value,
                  items: ['Any', ...controller.occupations.map((e) => e.name)],
                  onChanged: (v) => occupation.value = v!,
                ),
              ),
              const SizedBox(height: 20),

              // Dosham
              _buildFilterLabel(Icons.verified_user_outlined, 'DOSHAM'),
              Obx(
                () => _buildDropdown(
                  value: dosham.value,
                  items: ['Any', ...controller.doshams.map((e) => e.name)],
                  onChanged: (v) => dosham.value = v!,
                ),
              ),
              const SizedBox(height: 20),

              // Caste
              _buildFilterLabel(Icons.people_outline_rounded, 'CASTE'),
              Obx(
                () => _buildDropdown(
                  value: caste.value,
                  items: ['Any', ...controller.castes.map((e) => e.name)],
                  onChanged: (v) => caste.value = v!,
                ),
              ),
              const SizedBox(height: 20),

              // Marital Status
              _buildFilterLabel(
                Icons.person_add_alt_1_outlined,
                'MARITAL STATUS',
              ),
              Obx(
                () => _buildDropdown(
                  value: maritalStatus.value,
                  items: controller.maritalStatusOptions,
                  onChanged: (v) => maritalStatus.value = v!,
                ),
              ),
              const SizedBox(height: 20),

              // Job Location Country
              _buildFilterLabel(
                Icons.location_on_outlined,
                'JOB LOCATION COUNTRY',
              ),
              Obx(
                () => _buildDropdown(
                  value: workCountry.value,
                  items: controller.countryOptions,
                  onChanged: (v) => workCountry.value = v!,
                ),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  final filter = FilterModel(
                    minAge: minAge.value,
                    maxAge: maxAge.value,
                    annualIncome: annualIncome.value,
                    familyNetWorth: familyNetWorth.value,
                    education: education.value,
                    highestEducation: highestEducation.value,
                    occupation: occupation.value,
                    dosham: dosham.value,
                    caste: caste.value,
                    maritalStatus: maritalStatus.value,
                    workCountry: workCountry.value,
                  );
                  controller.applyFilters(filter);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const CommonText(
                  'Apply Filters',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildFilterLabel(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.accent),
          const SizedBox(width: 8),
          CommonText(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textGrey,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? hint,
  }) {
    // Ensure unique items and prevent duplicate 'Any' if it exists in data
    final uniqueItems = items.toSet().toList();

    // Ensure value exists in uniqueItems to avoid dropdown error
    String safeValue = uniqueItems.contains(value)
        ? value
        : (uniqueItems.isNotEmpty ? uniqueItems.first : '');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: safeValue.isEmpty ? null : safeValue,
          isExpanded: true,
          hint: hint != null ? CommonText(hint) : null,
          items: uniqueItems
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: CommonText(
                    e,
                    style: const TextStyle(color: AppColors.textDark),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _TinderMatchCard extends StatelessWidget {
  final UserModel match;
  const _TinderMatchCard({required this.match});

  @override
  Widget build(BuildContext context) {
    final hasPhoto =
        match.profilePhotoUrl.isNotEmpty && match.profilePhotoUrl != '';

    return GestureDetector(
      onTap: () => Get.toNamed(Routes.PROFILE_DETAILS, arguments: match),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              // Photo section
              Positioned.fill(
                child: hasPhoto
                    ? Image.network(
                        match.profilePhotoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            _PhotoPlaceholder(name: match.name),
                      )
                    : _PhotoPlaceholder(name: match.name),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Info section
              Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText(
                      match.name.trim(),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CommonText(
                        '${match.age} yrs · ${match.height}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (match.isCompleted)
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.verified_rounded,
                      color: AppColors.accent,
                      size: 20,
                    ),
                  ),
                ),
              if (match.interestStatus != null)
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_rounded,
                      color: Color(0xFFFF4B4B),
                      size: 24,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MatchGridCard extends StatelessWidget {
  final UserModel match;
  const _MatchGridCard({required this.match});

  @override
  Widget build(BuildContext context) {
    final hasPhoto =
        match.profilePhotoUrl.isNotEmpty && match.profilePhotoUrl != '';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () => Get.toNamed(Routes.PROFILE_DETAILS, arguments: match),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo section
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    hasPhoto
                        ? Image.network(
                            match.profilePhotoUrl,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                _PhotoPlaceholder(name: match.name),
                          )
                        : _PhotoPlaceholder(name: match.name),
                    if (match.isCompleted)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.verified_rounded,
                            color: AppColors.accent,
                            size: 16,
                          ),
                        ),
                      ),
                    if (match.interestStatus != null)
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite_rounded,
                            color: Color(0xFFFF4B4B),
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Info section
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        match.name.trim(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      CommonText(
                        '${match.age} yrs · ${match.height}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textGrey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () => Get.toNamed(
                          Routes.PROFILE_DETAILS,
                          arguments: match,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 36),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const CommonText(
                          'View Profile',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;
  final double size;

  const _CircleButton({
    required this.onPressed,
    required this.icon,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.5), width: 2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Center(
            child: Icon(icon, color: color, size: size * 0.5),
          ),
        ),
      ),
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  final String name;
  const _PhotoPlaceholder({required this.name});

  @override
  Widget build(BuildContext context) {
    final initials = name.trim().isNotEmpty
        ? name.trim()[0].toUpperCase()
        : '?';
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.primary.withOpacity(0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Sparkles
          Positioned(
            top: 40,
            left: 40,
            child: Opacity(
              opacity: 0.15,
              child: Icon(
                Icons.auto_awesome,
                color: AppColors.primary,
                size: 24,
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 40,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.auto_awesome,
                color: AppColors.primary,
                size: 32,
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: 60,
            child: Opacity(
              opacity: 0.08,
              child: Icon(
                Icons.auto_awesome,
                color: AppColors.primary,
                size: 20,
              ),
            ),
          ),

          // Central Diamond Decoration
          Transform.rotate(
            angle: 0.785, // 45 degrees
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          // Initials
          CommonText(
            initials,
            style: const TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              letterSpacing: 2,
            ),
          ),

          // Foreground Sparkle
          Positioned(
            top: 140,
            left: 60,
            child: Opacity(
              opacity: 0.2,
              child: Icon(
                Icons.auto_awesome,
                color: AppColors.primary,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
