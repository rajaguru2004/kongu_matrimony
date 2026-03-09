import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:kongu_matrimony/app/data/models/plan_model.dart';
import 'package:kongu_matrimony/app/data/services/auth_service.dart';
import 'package:kongu_matrimony/app/data/services/plans_service.dart';

class PlansController extends GetxController {
  final _auth = AuthService.to;
  final _service = PlansService();

  final RxList<PlanModel> plans = <PlanModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isBuying = false.obs;

  late final Razorpay _razorpay;

  // Used during payment verification
  PlanModel? _currentPlan;
  String? _pendingOrderId;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    fetchPlans();
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  // ── Fetch Plans ──────────────────────────────────────────────────────────

  Future<void> fetchPlans() async {
    isLoading.value = true;
    final result = await _service.fetchPlans(token: _auth.token);
    if (result != null) {
      plans.assignAll(result.where((p) => p.isActive).toList());
    } else {
      Get.snackbar(
        'Error',
        'Failed to load plans. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
    }
    isLoading.value = false;
  }

  // ── Buy Plan ─────────────────────────────────────────────────────────────

  Future<void> buyPlan(PlanModel plan) async {
    if (isBuying.value) return;
    isBuying.value = true;
    _currentPlan = plan;

    final order = await _service.createOrder(
      planId: plan.planId,
      token: _auth.token,
    );

    if (order == null) {
      Get.snackbar(
        'Error',
        'Could not create order. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
      isBuying.value = false;
      return;
    }

    _pendingOrderId = order['orderId'] as String;
    final int amount = order['amount'] as int; // paise
    final String keyId = dotenv.get(
      'RAZORPAY_KEY',
      fallback: order['keyId'] as String,
    );

    final options = <String, dynamic>{
      'key': keyId,
      'amount': amount,
      'currency': 'INR',
      'name': 'Kongu Matrimony',
      'description': '${plan.name} – ${plan.durationDays} Days',
      'order_id': _pendingOrderId,
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm'],
      },
      'theme': {'color': '#8B0000'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      isBuying.value = false;
    }
  }

  // ── Razorpay Callbacks ───────────────────────────────────────────────────

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    isBuying.value = false;

    final orderId = response.orderId ?? _pendingOrderId ?? '';
    final paymentId = response.paymentId ?? '';
    final signature = response.signature ?? '';

    final result = await _service.verifyPayment(
      razorpayOrderId: orderId,
      razorpayPaymentId: paymentId,
      razorpaySignature: signature,
      token: _auth.token,
    );

    if (result != null) {
      final planName = result['planName'] ?? _currentPlan?.name ?? 'Plan';
      Get.snackbar(
        '🎉 Membership Activated!',
        '$planName membership activated successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade700,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } else {
      Get.snackbar(
        'Payment Received',
        'Payment was successful but verification is pending. Contact support if needed.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade700,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    }

    _currentPlan = null;
    _pendingOrderId = null;
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    isBuying.value = false;
    _currentPlan = null;
    _pendingOrderId = null;
    // Do nothing on failure as per requirement
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    isBuying.value = false;
    _currentPlan = null;
    _pendingOrderId = null;
  }
}
