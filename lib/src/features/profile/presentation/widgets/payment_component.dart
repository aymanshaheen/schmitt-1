import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class PaymentComponent extends StatelessWidget {
  final String cardType;
  final String cardImage;
  const PaymentComponent(
      {super.key, required this.cardType, required this.cardImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: R.sH(context, 10)),
      child: Container(
        height: R.sH(context, 60),
        width: R.sW(context, R.W(context) - 30),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0C04060F),
              blurRadius: 60,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(right: R.sW(context, 10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                cardType,
                style: const TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 18,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                  height: 0.07,
                ),
              ),
              SizedBox(
                width: R.sW(context, 10),
              ),
              SvgPicture.asset(
                cardImage,
                width: 35,
                height: 35,
              ),
              SizedBox(
                width: R.sW(context, 10),
              ),
              const Text(
                'Connected',
                style: TextStyle(
                  color: Color(0xFF1C4274),
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                  height: 0.09,
                  letterSpacing: 0.20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
