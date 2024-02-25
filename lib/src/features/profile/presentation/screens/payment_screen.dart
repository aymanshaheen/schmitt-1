import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/payment_component.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/profile_app_bar.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: profileAppBar(
          title: 'Payment',
          context: context,
          isAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: const Column(
          children: [
            PaymentComponent(cardType: 'PayPal', cardImage: AppImage.payPal),
            PaymentComponent(
                cardType: 'Google Pay', cardImage: AppImage.google),
            PaymentComponent(cardType: 'Apple Pay', cardImage: AppImage.apple),
            PaymentComponent(
                cardType: 'Master Card', cardImage: AppImage.masterCard),
          ],
        ));
  }
}
