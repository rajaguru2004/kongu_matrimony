import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/user_model.dart';
import 'package:kongu_matrimony/app/utils/common_text.dart';
import '../controllers/matches_controller.dart';

const _kPrimary = Color(0xFF8B0000); // deep maroon
const _kPrimaryDark = Color(0xFF5D0000);
const _kAccent = Color(0xFFD4AF37); // gold
const _kBg = Color(0xFFFDFBF7); // refined warm ivory
const _kCard = Colors.white;
const _kTextPrimary = Color(0xFF2A0A0A);
const _kTextSecondary = Color(0xFF6B5E5E);

class MatchesView extends GetView<MatchesController> {
  const MatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
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
        backgroundColor: _kPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [_kPrimaryDark, _kPrimary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
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
            child: CircularProgressIndicator(color: _kPrimary),
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
                  color: _kPrimary.withOpacity(0.2),
                ),
                const SizedBox(height: 16),
                const CommonText(
                  'No profiles found for this section.',
                  style: TextStyle(color: _kTextSecondary, fontSize: 16),
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
      color: _kPrimary,
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
                  child: CircularProgressIndicator(color: _kPrimary),
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
}

class _TinderMatchCard extends StatelessWidget {
  final UserModel match;
  const _TinderMatchCard({required this.match});

  @override
  Widget build(BuildContext context) {
    final hasPhoto =
        match.profilePhotoUrl.isNotEmpty && match.profilePhotoUrl != '';

    return Container(
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
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
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
                      color: _kPrimary,
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
                    color: _kAccent,
                    size: 20,
                  ),
                ),
              ),
          ],
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
        color: _kCard,
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
          onTap: () {},
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
                            color: _kAccent,
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
                          color: _kTextPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      CommonText(
                        '${match.age} yrs · ${match.height}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: _kTextSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _kPrimary,
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
          colors: [_kPrimaryDark, _kPrimary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            color: Colors.white24,
          ),
        ),
      ),
    );
  }
}
