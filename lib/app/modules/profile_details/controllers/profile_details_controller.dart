import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongu_matrimony/app/data/services/api_service.dart';
import 'package:kongu_matrimony/app/data/services/auth_service.dart';
import 'package:kongu_matrimony/app/modules/home/controllers/home_controller.dart';
import 'package:kongu_matrimony/app/modules/matches/controllers/matches_controller.dart';
import '../../../data/models/user_model.dart';

class ProfileDetailsController extends GetxController {
  final _api = ApiService();
  final _auth = AuthService.to;
  final Rxn<UserModel> _user = Rxn<UserModel>();

  UserModel get user => _user.value!;

  @override
  void onInit() {
    super.onInit();
    _user.value = Get.arguments as UserModel;
  }

  Future<void> sendInterest() async {
    final success = await _api.sendInterest(
      senderId: _auth.registerId,
      receiverId: user.registerId,
      token: _auth.token,
    );

    if (success) {
      // Update local state reactively
      _user.value = user.copyWith(interestStatus: 'pending');

      // Refresh parent screens if they are in memory
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().fetchAll();
      }
      if (Get.isRegistered<MatchesController>()) {
        Get.find<MatchesController>().fetchProfiles();
      }

      Get.snackbar(
        'Interest Sent',
        'Your interest has been sent to ${user.name}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}
