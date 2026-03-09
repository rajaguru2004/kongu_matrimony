import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import '../../../utils/common_text.dart';
import '../controllers/profile_details_controller.dart';

// Theme colors are now centralized in AppColors

class ProfileDetailsView extends GetView<ProfileDetailsController> {
  const ProfileDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            _buildSliverAppBar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildHeaderInfo(),
                  _buildDetailSection(
                    title: 'About the Profile',
                    icon: Icons.person_outline_rounded,
                    content: controller.user.aboutYou,
                  ),
                  _buildContactInfo(),
                  _buildHoroscopeInfo(),
                  _buildCareerInfo(),
                  _buildFamilyInfo(),
                  _buildExpectationsInfo(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
        bottomSheet: _buildBottomAction(),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    final hasPhoto = controller.user.profilePhotoUrl.isNotEmpty;
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      backgroundColor: AppColors.primary,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (hasPhoto) ...[
              Image.network(
                controller.user.profilePhotoUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildPlaceholder(),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ] else
              _buildPlaceholder(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    final initials = controller.user.name.trim().isNotEmpty
        ? controller.user.name.trim()[0].toUpperCase()
        : '?';

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryDark, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Sparkles (White for visibility)
          Positioned(
            top: 100,
            left: 40,
            child: Opacity(
              opacity: 0.3,
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            right: 40,
            child: Opacity(
              opacity: 0.2,
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),
          Positioned(
            top: 160,
            right: 60,
            child: Opacity(
              opacity: 0.2,
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          // Central Diamond Decoration (Gold/Accent)
          Transform.rotate(
            angle: 0.785, // 45 degrees
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.accent.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
          ),

          // Initials (White)
          CommonText(
            initials,
            style: const TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 4,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),

          // Foreground Sparkle
          Positioned(
            top: 220,
            left: 80,
            child: Opacity(
              opacity: 0.4,
              child: const Icon(
                Icons.auto_awesome,
                color: AppColors.accent,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderInfo() {
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
                  controller.user.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              if (controller.user.isCompleted)
                const Icon(Icons.verified, color: AppColors.accent, size: 24),
            ],
          ),
          const SizedBox(height: 4),
          CommonText(
            'ID: ${controller.user.registerId}',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoChip(
                Icons.cake_rounded,
                '${controller.user.age} Years',
              ),
              const SizedBox(width: 8),
              _buildInfoChip(Icons.straighten_rounded, controller.user.height),
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
              fontSize: 13,
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
    required String content,
  }) {
    if (content.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
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

  Widget _buildContactInfo() {
    return _buildGridSection(
      title: 'Contact Information',
      icon: Icons.contact_phone_rounded,
      items: [
        _buildGridItem('Email', controller.user.email),
        _buildGridItem('Phone', controller.user.phone),
        _buildGridItem(
          'Location',
          '${controller.user.city ?? ''}, ${controller.user.state}',
        ),
      ],
    );
  }

  Widget _buildHoroscopeInfo() {
    return _buildGridSection(
      title: 'Horoscope & Religious',
      icon: Icons.star_rounded,
      items: [
        _buildGridItem('Caste', controller.user.yourCaste),
        _buildGridItem('Rasi', controller.user.yourRasi),
        _buildGridItem('Star', controller.user.yourStar),
        _buildGridItem('Dosham', controller.user.yourDosham),
      ],
    );
  }

  Widget _buildCareerInfo() {
    return _buildGridSection(
      title: 'Professional Career',
      icon: Icons.work_rounded,
      items: [
        _buildGridItem('Education', controller.user.highestEducation),
        _buildGridItem('Occupation', controller.user.occupation),
        _buildGridItem('Annual Income', controller.user.annualIncome),
        _buildGridItem('Work Location', controller.user.workLocation),
      ],
    );
  }

  Widget _buildFamilyInfo() {
    return _buildGridSection(
      title: 'Family Background',
      icon: Icons.family_restroom_rounded,
      items: [
        _buildGridItem('Father Name', controller.user.fatherName ?? 'N/A'),
        _buildGridItem('Father Occupation', controller.user.fatherOccupation),
        _buildGridItem('Mother Name', controller.user.motherName ?? 'N/A'),
        _buildGridItem('Mother Occupation', controller.user.motherOccupation),
        _buildGridItem(
          'Siblings',
          controller.user.siblingsCount?.toString() ?? 'N/A',
        ),
      ],
    );
  }

  Widget _buildExpectationsInfo() {
    return _buildDetailSection(
      title: 'Partner Expectation',
      icon: Icons.favorite_border_rounded,
      content: controller.user.partnerExpectation ?? '',
    );
  }

  Widget _buildGridSection({
    required String title,
    required IconData icon,
    required List<Widget> items,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Wrap(spacing: 20, runSpacing: 20, children: items),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
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
            value,
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

  Widget _buildBottomAction() {
    final isInterestSent = controller.user.interestStatus != null;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: isInterestSent ? null : () => controller.sendInterest(),
          style: ElevatedButton.styleFrom(
            backgroundColor: isInterestSent
                ? Colors.grey[300]
                : AppColors.primary,
            foregroundColor: isInterestSent ? Colors.grey[600] : Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: isInterestSent ? 0 : 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isInterestSent
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
              ),
              const SizedBox(width: 8),
              CommonText(
                isInterestSent ? 'Interest Sent' : 'Send Interest',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
