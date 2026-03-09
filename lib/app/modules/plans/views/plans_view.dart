import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/plan_model.dart';
import 'package:kongu_matrimony/app/utils/app_colors.dart';
import '../controllers/plans_controller.dart';

class PlansView extends GetView<PlansController> {
  const PlansView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          _buildAppBar(),
          _buildHeaderBadge(),
          _buildPlansList(),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────────────────────

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 160,
      pinned: true,
      elevation: 0,
      backgroundColor: AppColors.primary,
      surfaceTintColor: AppColors.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      title: const Text(
        'Membership Plans',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.3,
        ),
      ),
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        child: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryDark, AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // Decorative circles
                Positioned(
                  top: -30,
                  right: -30,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.05),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  left: -20,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.05),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Unlock Premium Features',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.workspace_premium_rounded,
                              color: AppColors.accent,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Find your perfect life partner',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Trust Badge Header ───────────────────────────────────────────────────

  SliverToBoxAdapter _buildHeaderBadge() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
        child: Row(
          children: [
            _Badge(
              icon: Icons.verified_user_rounded,
              label: 'Secure Payment',
              color: Colors.green.shade600,
            ),
            const SizedBox(width: 12),
            _Badge(
              icon: Icons.replay_rounded,
              label: 'Instant Activation',
              color: AppColors.accent,
            ),
            const SizedBox(width: 12),
            _Badge(
              icon: Icons.support_agent_rounded,
              label: '24/7 Support',
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  // ── Plans List ───────────────────────────────────────────────────────────

  SliverPadding _buildPlansList() {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      sliver: Obx(() {
        if (controller.isLoading.value) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, __) => const _PlanCardShimmer(),
              childCount: 3,
            ),
          );
        }

        if (controller.plans.isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: Center(
                child: Text(
                  'No plans available right now.',
                  style: TextStyle(color: AppColors.textGrey, fontSize: 15),
                ),
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final plan = controller.plans[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _PlanCard(plan: plan, controller: controller),
            );
          }, childCount: controller.plans.length),
        );
      }),
    );
  }
}

// ── Plan Card ────────────────────────────────────────────────────────────────

class _PlanCard extends StatelessWidget {
  final PlanModel plan;
  final PlansController controller;

  const _PlanCard({required this.plan, required this.controller});

  @override
  Widget build(BuildContext context) {
    final features = plan.description
        .split('\n')
        .where((f) => f.trim().isNotEmpty)
        .toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.accent.withOpacity(0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: AppColors.accent.withOpacity(0.06),
            blurRadius: 30,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryDark, AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(22),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.workspace_premium_rounded,
                    color: AppColors.accent,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        '${plan.durationDays}-Day Membership',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                // Price pill
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '₹${plan.price}',
                        style: const TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${plan.durationDays} days',
                        style: const TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Features ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What\'s included',
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                ...features.map((f) => _FeatureRow(feature: f)),
              ],
            ),
          ),

          // ── Buy Button ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Obx(() {
              final buying = controller.isBuying.value;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: buying
                        ? [Colors.grey.shade400, Colors.grey.shade400]
                        : [AppColors.accent, const Color(0xFFF5CB5C)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: buying
                      ? []
                      : [
                          BoxShadow(
                            color: AppColors.accent.withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: buying ? null : () => controller.buyPlan(plan),
                    child: Center(
                      child: buying
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.lock_open_rounded,
                                  color: AppColors.primaryDark,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Buy Now',
                                  style: TextStyle(
                                    color: AppColors.primaryDark,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ── Feature row ──────────────────────────────────────────────────────────────

class _FeatureRow extends StatelessWidget {
  final String feature;
  const _FeatureRow({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.primary,
              size: 14,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              feature,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Trust badge chip ─────────────────────────────────────────────────────────

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _Badge({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Shimmer placeholder card ──────────────────────────────────────────────────

class _PlanCardShimmer extends StatelessWidget {
  const _PlanCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 90,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade200,
                    Colors.grey.shade100,
                    Colors.grey.shade200,
                  ],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
