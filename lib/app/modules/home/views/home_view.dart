import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/user_model.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import 'package:kongu_matrimony/app/utils/common_text.dart';

import 'package:kongu_matrimony/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

// Theme colors are now centralized in AppColors

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: controller.fetchAll,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            _buildSliverAppBar(),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _SectionHeader(
                    title: "Today's Matches",
                    subtitle: "Handpicked for your preferences",
                    onViewAll: () => Get.toNamed(
                      Routes.MATCHES,
                      arguments: {'type': 'daily'},
                    ),
                  ),
                  _HorizontalMatchList(
                    listObs: controller.dailyRecommendations,
                    isLoadingObs: controller.isLoadingDaily,
                  ),
                  const SizedBox(height: 32),
                  _SectionHeader(
                    title: "Your Matches",
                    subtitle: "Compatible profiles for you",
                    onViewAll: () => Get.toNamed(
                      Routes.MATCHES,
                      arguments: {'type': 'yours'},
                    ),
                  ),
                  _HorizontalMatchList(
                    listObs: controller.yourMatches,
                    isLoadingObs: controller.isLoadingYourMatches,
                  ),
                  const SizedBox(height: 32),
                  _SectionHeader(
                    title: "Recently Joined",
                    subtitle: "Explore new members this week",
                    onViewAll: () => Get.toNamed(
                      Routes.MATCHES,
                      arguments: {'type': 'recent'},
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            _RecentlyJoinedSliverList(
              listObs: controller.recentlyJoined,
              isLoadingObs: controller.isLoadingRecent,
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  // ── App bar ──────────────────────────────────────────────────────────────
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      elevation: 0,
      backgroundColor: AppColors.primary,
      surfaceTintColor: AppColors.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      title: const CommonText(
        'Kongu Matrimony',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
        child: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryDark, AppColors.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              // Subtle Traditional Motif Pattern
              Positioned.fill(
                child: Opacity(
                  opacity: 0.1,
                  child: CustomPaint(painter: _TraditionalPatternPainter()),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 60, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonText(
                        'Search your life partner',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Modern Search/Filter Bar
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search_rounded,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: CommonText(
                                  'Search Profile ID or Name...',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                height: 24,
                                width: 1,
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.tune_rounded,
                                color: AppColors.primary,
                                size: 20,
                              ),
                            ],
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

// ── Background Pattern Painter ───────────────────────────────────────────
class _TraditionalPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const spacing = 40.0;
    for (double x = 0; x < size.width + spacing; x += spacing) {
      for (double y = 0; y < size.height + spacing; y += spacing) {
        canvas.drawCircle(Offset(x, y), 2, paint);
        // Add more intricate traditional-like strokes if desired
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Section header ────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onViewAll;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                    letterSpacing: -0.5,
                  ),
                ),
                CommonText(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onViewAll,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: AppColors.primary.withOpacity(0.05),
            ),
            child: Row(
              children: const [
                CommonText(
                  'View All',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.chevron_right, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Horizontal swipeable match cards (Today's Matches & Your Matches) ──────
class _HorizontalMatchList extends StatelessWidget {
  final RxList<UserModel> listObs;
  final RxBool isLoadingObs;

  const _HorizontalMatchList({
    required this.listObs,
    required this.isLoadingObs,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      child: Obx(() {
        if (isLoadingObs.value) {
          return _buildShimmerRow();
        }
        if (listObs.isEmpty) {
          return const Center(
            child: CommonText(
              'No profiles found.',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.only(left: 20, right: 6, top: 12),
          scrollDirection: Axis.horizontal,
          itemCount: listObs.length,
          itemBuilder: (context, index) {
            return _MatchCard(match: listObs[index]);
          },
        );
      }),
    );
  }

  Widget _buildShimmerRow() {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 20, right: 6, top: 12),
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (_, __) {
        return Container(
          width: 170,
          margin: const EdgeInsets.only(right: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

// ── Individual match card ─────────────────────────────────────────────────
class _MatchCard extends StatelessWidget {
  final UserModel match;
  const _MatchCard({required this.match});

  @override
  Widget build(BuildContext context) {
    final hasPhoto =
        match.profilePhotoUrl.isNotEmpty && match.profilePhotoUrl != '';

    return Container(
      width: 190,
      margin: const EdgeInsets.only(right: 16, bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: () => Get.toNamed(Routes.PROFILE_DETAILS, arguments: match),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Photo section ───────────────────────────────────────────
              Stack(
                children: [
                  hasPhoto
                      ? Image.network(
                          match.profilePhotoUrl,
                          width: double.infinity,
                          height: 155,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              _PhotoPlaceholder(name: match.name),
                        )
                      : _PhotoPlaceholder(name: match.name),
                  if (match.isCompleted)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4),
                            CommonText(
                              'Verified',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (match.interestStatus != null)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: Color(0xFFFF4B4B),
                          size: 18,
                        ),
                      ),
                    ),
                ],
              ),
              // ── Info section ────────────────────────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        match.name.trim(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      _infoRow(
                        match.age.isNotEmpty ? '${match.age} yrs' : '',
                        match.height,
                      ),
                    ],
                  ),
                ),
              ),
              // ── Express Interest button ─────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Container(
                  width: double.infinity,
                  height: 38,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryLight],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () =>
                        Get.toNamed(Routes.PROFILE_DETAILS, arguments: match),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const CommonText(
                      'View Profile',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String age, String height) {
    final parts = [age, height].where((s) => s.isNotEmpty).join(' · ');
    if (parts.isEmpty) return const SizedBox.shrink();
    return CommonText(
      parts,
      style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
      overflow: TextOverflow.ellipsis,
    );
  }
}

// ── Photo placeholder ─────────────────────────────────────────────────────
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
      height: 155,
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
          // Subtle traditional motif icon in background
          Opacity(
            opacity: 0.1,
            child: Icon(
              Icons.auto_awesome, // replaced with something traditional-looking
              size: 80,
              color: AppColors.primary,
            ),
          ),
          CommonText(
            initials,
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Recently Joined — responsive sliver grid ──────────────────────────────
class _RecentlyJoinedSliverList extends StatelessWidget {
  final RxList<UserModel> listObs;
  final RxBool isLoadingObs;

  const _RecentlyJoinedSliverList({
    required this.listObs,
    required this.isLoadingObs,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isLoadingObs.value) {
        return const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),
        );
      }
      if (listObs.isEmpty) {
        return const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: CommonText(
                'No new profiles found.',
                style: TextStyle(color: AppColors.textGrey),
              ),
            ),
          ),
        );
      }

      final width = MediaQuery.of(context).size.width;
      final crossAxisCount = width > 900 ? 3 : (width > 600 ? 2 : 1);
      final childAspectRatio = width > 900 ? 1.5 : (width > 600 ? 1.4 : 2.8);

      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: childAspectRatio,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            return _RecentCard(match: listObs[index]);
          }, childCount: listObs.length),
        ),
      );
    });
  }
}

// ── Recently joined horizontal card ───────────────────────────────────────
class _RecentCard extends StatelessWidget {
  final UserModel match;
  const _RecentCard({required this.match});

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
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.accent.withOpacity(0.1),
          width: 0.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () => Get.toNamed(Routes.PROFILE_DETAILS, arguments: match),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // ── Avatar ─────────────────────────────────────────────────
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: hasPhoto
                          ? Image.network(
                              match.profilePhotoUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  _SmallPlaceholder(name: match.name),
                            )
                          : _SmallPlaceholder(name: match.name),
                    ),
                    if (match.isCompleted)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.verified_rounded,
                            color: AppColors.accent,
                            size: 18,
                          ),
                        ),
                      ),
                    if (match.interestStatus != null)
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite_rounded,
                            color: Color(0xFFFF4B4B),
                            size: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                // ── Details ────────────────────────────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonText(
                        match.name.trim(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      _row([
                        if (match.age.isNotEmpty) '${match.age} yrs',
                        if (match.height.isNotEmpty) match.height,
                      ]),
                    ],
                  ),
                ),
                // ── Action ───────────────────────────────────────────────
                const SizedBox(width: 8),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    match.interestStatus != null
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(List<String> parts) {
    final text = parts.where((s) => s.isNotEmpty).join(' · ');
    if (text.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: CommonText(
        text,
        style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

// ── Small avatar placeholder ───────────────────────────────────────────────
class _SmallPlaceholder extends StatelessWidget {
  final String name;
  const _SmallPlaceholder({required this.name});

  @override
  Widget build(BuildContext context) {
    final initials = name.trim().isNotEmpty
        ? name.trim()[0].toUpperCase()
        : '?';
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
