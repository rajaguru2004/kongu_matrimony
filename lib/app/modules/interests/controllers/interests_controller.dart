import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/models/interest_model.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/data/services/auth_service.dart';

class InterestsController extends GetxController {
  final _api = ApiService();
  final _auth = AuthService.to;

  final RxList<InterestModel> interests = <InterestModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInterests();
  }

  void refreshInterests() {
    fetchInterests();
  }

  Future<void> fetchInterests() async {
    if (!_auth.isAuthenticated) return;

    isLoading.value = true;

    final result = await _api.getSentInterests(
      registerId: _auth.registerId,
      token: _auth.token,
    );

    if (result != null) {
      interests.assignAll(result.data);
    }

    isLoading.value = false;
  }

  Future<void> cancelInterest(String interestId) async {
    if (!_auth.isAuthenticated) return;

    isLoading.value = true;
    final success = await _api.cancelInterest(
      interestId: interestId,
      token: _auth.token,
    );

    if (success) {
      await fetchInterests();
      Get.snackbar(
        'Success',
        'Interest cancelled successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      isLoading.value = false;
    }
  }
}
