import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:schmitt/src/core/widgets/responsivity.dart";
import "package:schmitt/src/features/booking_details/presentation/screens/location_screen.dart";
import "package:schmitt/src/features/booking_details/presentation/widgets/booking_app_bar.dart";

class LocationLayoutScreen extends StatefulWidget {
  const LocationLayoutScreen({super.key});

  @override
  State<LocationLayoutScreen> createState() => _LocationLayoutScreenState();
}

class _LocationLayoutScreenState extends State<LocationLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          bookingAppBar(context: context, title: "Your Adddress/Location".tr()),
      body: Column(
        children: [
          SizedBox(
            height: R.sH(context, R.H(context) * 3 / 4),
            child: const LocationScreen(),
          )
        ],
      ),
    );
  }
}
