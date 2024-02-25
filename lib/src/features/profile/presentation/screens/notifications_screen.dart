import 'package:flutter/material.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/notifications_settings_component.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/profile_app_bar.dart';

class NotificationsScreenSettings extends StatefulWidget {
  const NotificationsScreenSettings({super.key});

  @override
  State<NotificationsScreenSettings> createState() =>
      _NotificationsScreenSettingsState();
}

class _NotificationsScreenSettingsState
    extends State<NotificationsScreenSettings> {
  bool generalNotification = false;

  bool sound = false;

  bool vibrate = false;

  bool payments = false;

  bool specialOffers = false;

  bool promoDiscount = false;

  bool cashback = false;

  bool appUpdates = false;

  bool newServiceAvailable = false;

  bool newTipsAvailable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: profileAppBar(
          title: 'Notifications',
          context: context,
          isAction: false,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Column(
          children: [
            NotificationsSettingsComponent(
              onChange: (value) {
                setState(() {
                  generalNotification = value;
                });
              },
              switchValue: generalNotification,
              title: 'General Notifications',
            ),
            NotificationsSettingsComponent(
              onChange: (value) {
                setState(() {
                  sound = value;
                });
              },
              switchValue: sound,
              title: 'Sound',
            ),
            NotificationsSettingsComponent(
              onChange: (value) {
                setState(() {
                  vibrate = value;
                });
              },
              switchValue: vibrate,
              title: 'Vibrate',
            ),
            NotificationsSettingsComponent(
              onChange: (value) {
                setState(() {
                  specialOffers = value;
                });
              },
              switchValue: specialOffers,
              title: 'Special Offers',
            ),
            NotificationsSettingsComponent(
              onChange: (value) {
                setState(() {
                  promoDiscount = value;
                });
              },
              switchValue: promoDiscount,
              title: "Promo & Discounts",
            ),
            NotificationsSettingsComponent(
              onChange: (value) {
                setState(() {
                  payments = value;
                });
              },
              switchValue: payments,
              title: 'Payments',
            ),
            NotificationsSettingsComponent(
              onChange: (value) {
                setState(() {
                  cashback = value;
                });
              },
              switchValue: cashback,
              title: 'Cashback',
            ),
            NotificationsSettingsComponent(
              onChange: (value) {
                setState(() {
                  appUpdates = value;
                });
              },
              switchValue: appUpdates,
              title: 'App Updates',
            ),
            NotificationsSettingsComponent(
              onChange: (value) {
                setState(() {
                  newServiceAvailable = value;
                });
              },
              switchValue: newServiceAvailable,
              title: 'New Service Available',
            ),
            NotificationsSettingsComponent(
              onChange: (value) {
                setState(() {
                  newTipsAvailable = value;
                });
              },
              switchValue: newTipsAvailable,
              title: 'New Tips Available',
            ),
          ],
        ));
  }
}
