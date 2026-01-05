import 'package:e_commerce_app/Controller/TabBar/Account/PaymentController.dart';
import 'package:e_commerce_app/Custom_Functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.put(PaymentController());

    return Scaffold(
      appBar: Custom_Functions.getAppbar("CheckOut"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary
            _sectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Summary",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12),
                  _PriceRow("Product", "Premium Plan"),
                  SizedBox(height: 6),
                  _PriceRow("Amount", "${paymentController.getprice}"),
                  Divider(height: 24),
                  _PriceRow(
                    "Total",
                    "${paymentController.getprice}",
                    isBold: true,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Card Details
            _sectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Card Details",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12),
                  CardField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Card number",
                    ),
                    onCardChanged: paymentController.onCardChanged,
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Pay Button
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed:
                      paymentController.isCardComplete.value &&
                          !paymentController.isLoading.value
                      ? paymentController.startPayment
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: paymentController.isLoading.value
                      ? SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "Pay ${paymentController.getprice}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),

            SizedBox(height: 16),

            // Disclaimer
            Center(
              child: Text(
                "This is a demo payment screen.\nNo real payment is processed.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable card container
  Widget _sectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

// Price row widget
class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _PriceRow(this.label, this.value, {this.isBold = false});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 14,
      fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}
