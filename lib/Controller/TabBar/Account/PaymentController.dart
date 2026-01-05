import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentController extends GetxController {
  final isCardComplete = false.obs;
  final isLoading = false.obs;
  RxString getprice = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getprice.value = Get.arguments["Price"].toString();
  }

  void onCardChanged(CardFieldInputDetails? card) {
    isCardComplete.value = card?.complete ?? false;
  }

  void showMessage(String text) {
    Get.snackbar("Payment", text, snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> startPayment() async {
    try {
      isLoading.value = true;

      const mockClientSecret = "pi_test_secret_dummy_for_learning_only";

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: mockClientSecret,
          merchantDisplayName: "Demo Store",
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      showMessage("Payment flow completed (mock)");
    } on StripeException {
      showMessage("Payment cancelled");
    } catch (_) {
      showMessage("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
