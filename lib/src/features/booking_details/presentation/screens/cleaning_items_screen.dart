import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/booking_details/presentation/widgets/booking_app_bar.dart';
import 'package:schmitt/src/features/booking_details/presentation/widgets/booking_button.dart';
import 'package:schmitt/src/features/booking_details/presentation/widgets/cleaning_item.dart';

class CleaningItemsScreen extends StatefulWidget {
  const CleaningItemsScreen({super.key});

  @override
  State<CleaningItemsScreen> createState() => _CleaningItemsScreenState();
}

class _CleaningItemsScreenState extends State<CleaningItemsScreen> {
  List<String> cleaningItems = [
    'Living Room',
    'Kitchen',
    'Bedroom',
    'Bathroom',
    'Terrace',
    'Dining Room',
    'Garage',
  ];
  int cleanCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: bookingAppBar(context: context, title: 'Housekeeping'.tr()),
        body: Padding(
          padding: EdgeInsets.only(
            left: R.sW(context, 15),
            right: R.sW(context, 15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter the number of items to be cleaned.',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: R.sH(context, 600),
                child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: ((context, index) {
                    return CleaningItem(
                      trillingWidget: Text(
                        cleaningItems[index],
                        style: const TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 18,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: R.sH(context, 20),
              ),
              BookingButton(
                text: 'Continue'.tr(),
                onTap: () {
                  Navigator.pushNamed(context, Routes.bookingDate);
                },
              )
            ],
          ),
        ));
  }
}
