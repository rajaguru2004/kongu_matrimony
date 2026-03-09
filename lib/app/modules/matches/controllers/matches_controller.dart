import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/filter_model.dart';
import 'package:kongu_matrimony/app/data/models/matches_response_model.dart';
import 'package:kongu_matrimony/app/data/models/setup_model.dart';
import 'package:kongu_matrimony/app/endpoints.dart';
import 'package:kongu_matrimony/app/data/models/user_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/data/services/auth_service.dart';
import 'package:kongu_matrimony/app/modules/home/controllers/home_controller.dart';

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

  // Filters
  final Rx<FilterModel?> activeFilter = Rx<FilterModel?>(null);

  // Filter Options (Dynamic)
  final RxList<SetupItem> doshams = <SetupItem>[].obs;
  final RxList<SetupItem> castes = <SetupItem>[].obs;
  final RxList<SetupItem> educations = <SetupItem>[].obs;
  final RxList<SetupItem> occupations = <SetupItem>[].obs;

  final List<String> incomeOptions = [
    'Any',
    'Below 2 Lakhs',
    '2 - 5 Lakhs',
    '5 - 10 Lakhs',
    '10 - 20 Lakhs',
    'Above 20 Lakhs',
  ];

  final List<String> maritalStatusOptions = [
    'Any',
    'Unmarried',
    'Divorced',
    'Widowed',
    'Awaiting Divorce',
  ];
  final List<String> countryOptions = [
    'Any',
    'India',
    'USA',
    'UK',
    'Canada',
    'Australia',
    'Singapore',
    'UAE',
  ];

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
    _fetchSetupData();
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

  Future<void> _fetchSetupData() async {
    try {
      final results = await Future.wait([
        _api.getSetupData(Endpoints.doshams),
        _api.getSetupData(Endpoints.castes),
        _api.getSetupData(Endpoints.educations),
        _api.getSetupData(Endpoints.occupations),
      ]);

      if (results[0] != null) doshams.assignAll(results[0]!.data);
      if (results[1] != null) castes.assignAll(results[1]!.data);
      if (results[2] != null) educations.assignAll(results[2]!.data);
      if (results[3] != null) occupations.assignAll(results[3]!.data);
    } catch (e) {
      debugPrint('Error fetching setup data: $e');
    }
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
        filter: activeFilter.value,
      );
    } else if (type == 'yours') {
      result = await _api.getYourMatches(
        registerId: _auth.registerId,
        token: _auth.token,
        page: pageToFetch,
        limit: limit,
        filter: activeFilter.value,
      );
    } else if (type == 'recent') {
      result = await _api.getRecentlyJoined(
        registerId: _auth.registerId,
        token: _auth.token,
        page: pageToFetch,
        limit: limit,
        filter: activeFilter.value,
      );
    } else {
      result = await _api.getMatches(
        registerId: _auth.registerId,
        token: _auth.token,
        page: pageToFetch,
        limit: limit,
        filter: activeFilter.value,
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

  void applyFilters(FilterModel filter) {
    activeFilter.value = filter;
    fetchProfiles();
    Get.back();
  }

  void resetFilters() {
    activeFilter.value = null;
    fetchProfiles();
    Get.back();
  }

  bool onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );

    // Send interest on right swipe
    if (direction == CardSwiperDirection.right) {
      sendInterest(profiles[previousIndex]);
    }

    // Check if we need to load more cards in Tinder view
    if (currentIndex != null && currentIndex >= profiles.length - 3) {
      fetchProfiles(loadMore: true);
    }

    return true;
  }

  void swipeLeft() => swiperController.swipe(CardSwiperDirection.left);
  void swipeRight() => swiperController.swipe(CardSwiperDirection.right);

  Future<void> sendInterest(UserModel targetUser) async {
    final success = await _api.sendInterest(
      senderId: _auth.registerId,
      receiverId: targetUser.registerId,
      token: _auth.token,
    );

    if (success) {
      final index = profiles.indexWhere(
        (p) => p.registerId == targetUser.registerId,
      );
      if (index != -1) {
        profiles[index] = targetUser.copyWith(interestStatus: 'pending');
      }

      // Refresh Home screen if it exists
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().fetchAll();
      }

      Get.snackbar(
        'Interest Sent',
        'Your interest has been sent to ${targetUser.name}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}
