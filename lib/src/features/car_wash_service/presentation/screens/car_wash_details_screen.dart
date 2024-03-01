import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/features/car_wash_service/presentation/widgets/car_wash_app_bar.dart';
import 'package:schmitt/src/features/car_wash_service/presentation/widgets/drop_down_car_wash.dart';

import '../../../../core/widgets/responsivity.dart';

class CarWashDetailsScreen extends StatefulWidget {
  const CarWashDetailsScreen({super.key});

  @override
  State<CarWashDetailsScreen> createState() => _CarWashDetailsScreenState();
}

class _CarWashDetailsScreenState extends State<CarWashDetailsScreen> {
  List<String> carType = ['Sedan', 'SUV', 'Truck'];
  List<String> carModel = ['BMW', 'Audi', 'Mercedes'];
  String selectedCarType = 'Car Type';
  String selectedCarModel = 'Car Model';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: carWashAppBar(context: context, title: 'Car Washing'.tr()),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: R.sH(
                  context,
                  15,
                ),
                left: R.sW(context, 15)),
            child: const Text(
              'ensert the type and the model of your car',
              style: TextStyle(
                color: Color(0xFF212121),
                fontSize: 16,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          DropDownCarWash(
              dropDownHint: 'Car Type'.tr(),
              selectedItem: selectedCarType,
              dropDownItems: carType,
              dropDownTitle: 'Car Type'.tr()),
          DropDownCarWash(
              dropDownHint:  'Car Model'.tr(),
              selectedItem: selectedCarModel,
              dropDownItems: carModel,
              dropDownTitle: 'Car Model'.tr()),
          Text('Car Number'.tr()),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Enter your car number',
              hintStyle: TextStyle(
                color: Color(0xFF212121),
                fontSize: 16,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
