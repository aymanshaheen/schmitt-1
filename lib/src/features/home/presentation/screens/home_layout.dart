import 'package:flutter/material.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/widgets/home_bar.dart';
import 'package:schmitt/src/features/home/presentation/widgets/most_services.dart';
import 'package:schmitt/src/features/home/presentation/widgets/special_offers.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({super.key});

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: R.sH(context, 10),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(
                  top: R.sH(context, 10),
                  left: R.sW(context, 15),
                  right: R.sW(context, 15)),
              child: const HomeBar(),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: R.sW(context, 15), right: R.sW(context, 15)),
                      child: const SpecialOffers(),
                    ),
                    SizedBox(
                      height: R.sH(context, 10),
                    ),
                     const MostServices( ),
                     
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

}
