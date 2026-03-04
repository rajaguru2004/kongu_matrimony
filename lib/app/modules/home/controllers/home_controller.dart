import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/user_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/data/services/auth_service.dart';

class HomeController extends GetxController {
  final _api = ApiService();
  final _auth = AuthService.to;

  // ── Daily Recommendations ──────────────────────────────────────────────────
  final RxList<UserModel> dailyRecommendations = <UserModel>[].obs;
  final RxBool isLoadingDaily = false.obs;

  // ── Your Matches ───────────────────────────────────────────────────────────
  final RxList<UserModel> yourMatches = <UserModel>[].obs;
  final RxBool isLoadingYourMatches = false.obs;

  // ── Recently Joined ────────────────────────────────────────────────────────
  final RxList<UserModel> recentlyJoined = <UserModel>[].obs;
  final RxBool isLoadingRecent = false.obs;

  // Legacy observable kept for backward compatibility
  final RxList<UserModel> matches = <UserModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  Future<void> fetchAll() async {
    if (!_auth.isAuthenticated) return;
    await Future.wait([
      fetchDailyRecommendations(),
      fetchYourMatches(),
      fetchRecentlyJoined(),
    ]);
  }

  Future<void> fetchDailyRecommendations() async {
    if (!_auth.isAuthenticated) return;
    isLoadingDaily.value = true;
    final result = await _api.getDailyRecommendations(
      registerId: _auth.registerId,
      token: _auth.token,
    );
    if (result != null) {
      dailyRecommendations.assignAll(result.data);
      matches.assignAll(result.data); // keep legacy
    }
    isLoadingDaily.value = false;
  }

  Future<void> fetchYourMatches() async {
    if (!_auth.isAuthenticated) return;
    isLoadingYourMatches.value = true;
    final result = await _api.getYourMatches(
      registerId: _auth.registerId,
      token: _auth.token,
    );
    if (result != null) {
      yourMatches.assignAll(result.data);
    }
    isLoadingYourMatches.value = false;
  }

  Future<void> fetchRecentlyJoined() async {
    if (!_auth.isAuthenticated) return;
    isLoadingRecent.value = true;
    final result = await _api.getRecentlyJoined(
      registerId: _auth.registerId,
      token: _auth.token,
    );
    if (result != null) {
      recentlyJoined.assignAll(result.data);
    }
    isLoadingRecent.value = false;
  }
}
