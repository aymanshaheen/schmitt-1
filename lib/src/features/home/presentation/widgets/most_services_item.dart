import 'package:flutter/material.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/features/home/presentation/widgets/service_item.dart';

class MostServices extends StatefulWidget {
  const MostServices({super.key});

  @override
  _MostServicesState createState() => _MostServicesState();
}

class _MostServicesState extends State<MostServices> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey.withOpacity(0.05),
      child: ListView.builder(
        itemCount: 4,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () => Navigator.pushNamed(context, Routes.service),
              child: const ServiceItem(
                title: 'housekeeping',
              ));
        },
      ),
    );
  }
}
