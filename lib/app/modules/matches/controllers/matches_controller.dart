import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/matches_response_model.dart';
import 'package:kongu_matrimony/app/data/models/user_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/data/services/auth_service.dart';

class MatchesController extends GetxController {
  final _api = ApiService();
  final _auth = AuthService.to;

  final RxList<UserModel> profiles = <UserModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isMoreLoading = false.obs;
  final RxString title = 'Matches'.obs;

  // Pagination state
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxBool hasNextPage = false.obs;
  final RxBool hasPrevPage = false.obs;

  // View Mode (Grid vs Swipe)
  final RxBool isSwipeMode = false.obs;

  // Card Swiper
  final CardSwiperController swiperController = CardSwiperController();

  // Scroll Controller for GridView
  final ScrollController scrollController = ScrollController();

  late String type;

  @override
  void onInit() {
    super.onInit();
    type = Get.arguments?['type'] ?? 'daily';
    _setTitle();
    fetchProfiles();

    // Add scroll listener for infinite scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        fetchProfiles(loadMore: true);
      }
    });
  }

  @override
  void onClose() {
    swiperController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void toggleView() {
    isSwipeMode.value = !isSwipeMode.value;
  }

  void _setTitle() {
    switch (type) {
      case 'daily':
        title.value = "Today's Matches";
        break;
      case 'yours':
        title.value = "Your Matches";
        break;
      case 'recent':
        title.value = "Recently Joined";
        break;
      case 'all':
        title.value = "New Matches";
        break;
      default:
        title.value = "Matches";
    }
  }

  Future<void> fetchProfiles({bool loadMore = false}) async {
    if (!_auth.isAuthenticated) return;

    if (loadMore) {
      if (!hasNextPage.value || isMoreLoading.value) return;
      isMoreLoading.value = true;
    } else {
      isLoading.value = true;
      currentPage.value = 1;
    }

    MatchesResponseModel? result;
    const int limit = 8;
    final int pageToFetch = loadMore ? currentPage.value + 1 : 1;

    if (type == 'daily') {
      result = await _api.getDailyRecommendations(
        registerId: _auth.registerId,
        token: _auth.token,
        page: pageToFetch,
        limit: limit,
      );
    } else if (type == 'yours') {
      result = await _api.getYourMatches(
        registerId: _auth.registerId,
        token: _auth.token,
        page: pageToFetch,
        limit: limit,
      );
    } else if (type == 'recent') {
      result = await _api.getRecentlyJoined(
        registerId: _auth.registerId,
        token: _auth.token,
        page: pageToFetch,
        limit: limit,
      );
    } else {
      result = await _api.getMatches(
        registerId: _auth.registerId,
        token: _auth.token,
        page: pageToFetch,
        limit: limit,
      );
    }

    if (result != null) {
      if (loadMore) {
        // Filter out duplicates just in case
        final existingIds = profiles.map((p) => p.id).toSet();
        final newData = result.data
            .where((p) => !existingIds.contains(p.id))
            .toList();
        profiles.addAll(newData);
      } else {
        profiles.assignAll(result.data);
      }

      if (result.pagination != null) {
        currentPage.value = result.pagination!.page;
        totalPages.value = result.pagination!.totalPages;
        hasNextPage.value = result.pagination!.hasNextPage;
        hasPrevPage.value = result.pagination!.hasPrevPage;
      }
    }

    isLoading.value = false;
    isMoreLoading.value = false;
  }

  bool onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );

    // Check if we need to load more cards in Tinder view
    if (currentIndex != null && currentIndex >= profiles.length - 3) {
      fetchProfiles(loadMore: true);
    }

    return true;
  }

  void swipeLeft() => swiperController.swipe(CardSwiperDirection.left);
  void swipeRight() => swiperController.swipe(CardSwiperDirection.right);
}
