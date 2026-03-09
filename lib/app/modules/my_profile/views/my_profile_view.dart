import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import '../../../utils/common_text.dart';
import '../controllers/my_profile_controller.dart';

// Theme colors are now centralized in AppColors

class MyProfileView extends GetView<MyProfileController> {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (controller.error.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText(
                  controller.error.value,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchMyProfile(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final user = controller.user;
        if (user == null) {
          return const Center(child: Text('No user data found'));
        }

        return CustomScrollView(
          slivers: [
            _buildSliverAppBar(context, user),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildHeaderInfo(user),
                  _buildDetailSection(
                    title: 'About You',
                    icon: Icons.person_outline_rounded,
                    content: user.aboutYou,
                  ),
                  _buildBasicInfo(user),
                  _buildAddressInfo(user),
                  _buildCasteInfo(user),
                  _buildFamilyInfo(user),
                  _buildCareerInfo(user),
                  _buildPartnerPrefInfo(user),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, user) {
    final hasPhoto =
        user.profilePhotoUrl != null && user.profilePhotoUrl!.isNotEmpty;
    return SliverAppBar(
      expandedHeight: 350,
      pinned: true,
      backgroundColor: AppColors.primary,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          onPressed: () => _showLogoutDialog(context),
          icon: const Icon(Icons.logout, color: Colors.white),
          tooltip: 'Logout',
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (hasPhoto) ...[
              Image.network(
                user.profilePhotoUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildPlaceholder(user),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
            ] else
              _buildPlaceholder(user),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(user) {
    final initials = (user.name ?? '').trim().isNotEmpty
        ? user.name!.trim()[0].toUpperCase()
        : '?';

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryDark, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: CommonText(
          initials,
          style: const TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderInfo(user) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CommonText(
                  user.name ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              if (user.isCompleted == true)
                const Icon(Icons.verified, color: AppColors.accent, size: 24),
            ],
          ),
          const SizedBox(height: 4),
          CommonText(
            'ID: ${user.registerId}',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              _buildInfoChip(Icons.cake_rounded, '${user.age} Years'),
              _buildInfoChip(Icons.straighten_rounded, user.height ?? 'N/A'),
              _buildInfoChip(
                Icons.person_pin_circle_rounded,
                user.maritalStatus ?? 'N/A',
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: AppColors.accent, thickness: 0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 6),
          CommonText(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection({
    required String title,
    required IconData icon,
    required String? content,
  }) {
    if (content == null || content.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(title, icon),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: _boxDecoration(),
            child: CommonText(
              content,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textGrey,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfo(user) {
    return _buildGridSection(
      title: 'Basic Information',
      icon: Icons.info_outline_rounded,
      items: [
        _buildGridItem('Gender', user.gender),
        _buildGridItem('DOB', user.dob),
        _buildGridItem('Time of Birth', user.timeOfBirth),
        _buildGridItem('Place of Birth', user.placeOfBirth),
        _buildGridItem('Phone', user.phone),
        _buildGridItem('Alt Phone', user.alternatePhone),
        _buildGridItem('Email', user.email),
      ],
    );
  }

  Widget _buildAddressInfo(user) {
    return _buildGridSection(
      title: 'Address',
      icon: Icons.location_on_outlined,
      items: [
        _buildGridItem('Address', user.address),
        _buildGridItem('City', user.city),
        _buildGridItem('State', user.state),
        _buildGridItem('Country', user.country),
        _buildGridItem('Pincode', user.pincode),
      ],
    );
  }

  Widget _buildCasteInfo(user) {
    return _buildGridSection(
      title: 'Caste & Religious',
      icon: Icons.temple_hindu_outlined,
      items: [
        _buildGridItem('Caste', user.yourCaste),
        _buildGridItem('Kootam', user.yourKootam),
        _buildGridItem('Dosham', user.yourDosham),
        _buildGridItem('Star', user.yourStar),
        _buildGridItem('Rasi', user.yourRasi),
      ],
    );
  }

  Widget _buildFamilyInfo(user) {
    return _buildGridSection(
      title: 'Family Details',
      icon: Icons.family_restroom_rounded,
      items: [
        _buildGridItem('Family Status', user.familyStatus),
        _buildGridItem('Family Type', user.familyType),
        _buildGridItem('Family Values', user.familyValues),
        _buildGridItem('Father Occupation', user.fatherOccupation),
        _buildGridItem('Mother Occupation', user.motherOccupation),
      ],
    );
  }

  Widget _buildCareerInfo(user) {
    return _buildGridSection(
      title: 'Education & Career',
      icon: Icons.school_outlined,
      items: [
        _buildGridItem('Education', user.highestEducation),
        _buildGridItem('Employed In', user.employedIn),
        _buildGridItem('Occupation', user.occupation),
        _buildGridItem('Work Location', user.workLocation),
        _buildGridItem('Annual Income', user.annualIncome),
      ],
    );
  }

  Widget _buildPartnerPrefInfo(user) {
    return _buildGridSection(
      title: 'Partner Preference',
      icon: Icons.favorite_border_rounded,
      items: [
        _buildGridItem('Marital Status', user.partnerMaritalStatus),
        _buildGridItem('Education', user.partnerEducation),
        _buildGridItem('Profession', user.partnerProfession),
        _buildGridItem('Caste', user.partnerCaste),
        _buildGridItem('Star', user.partnerStar),
        _buildGridItem('Rasi', user.partnerRasi),
        _buildGridItem('Dosham', user.partnerDosham),
      ],
    );
  }

  Widget _buildGridSection({
    required String title,
    required IconData icon,
    required List<Widget?> items,
  }) {
    final activeItems = items.whereType<Widget>().toList();
    if (activeItems.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(title, icon),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: _boxDecoration(),
            child: Wrap(spacing: 20, runSpacing: 20, children: activeItems),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(width: 10),
        CommonText(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget? _buildGridItem(String label, dynamic value) {
    final displayValue = value?.toString() ?? '';
    if (displayValue.isEmpty || displayValue == 'null') return null;

    return SizedBox(
      width: (Get.width - 100) / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          CommonText(
            displayValue,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      border: Border.all(color: AppColors.accent.withAlpha(30)),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const CommonText(
          'Logout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const CommonText('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const CommonText(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.logout();
            },
            child: const CommonText(
              'Yes, Logout',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
