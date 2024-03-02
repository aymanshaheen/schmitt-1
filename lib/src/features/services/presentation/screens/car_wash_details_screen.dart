import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_state.dart';
import 'package:schmitt/src/features/services/presentation/widgets/drop_down_car_wash.dart';

import '../../../../core/widgets/responsivity.dart';

class CarWashDetailsScreen extends StatefulWidget {
  const CarWashDetailsScreen({super.key});

  @override
  State<CarWashDetailsScreen> createState() => _CarWashDetailsScreenState();
}

class _CarWashDetailsScreenState extends State<CarWashDetailsScreen> {
  List<String> carType = ['Car Type', 'Sedan', 'SUV', 'Truck'];
  List<String> carModel = ['Car Model', 'BMW', 'Audi', 'Mercedes'];
  String selectedCarType = 'Car Type';
  String selectedCarModel = 'Car Model';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ServiceCubit serviceCubit = ServiceCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              centerTitle: false,
              leadingWidth: R.sW(context, 25),
              elevation: 0,
              title: Text(
                AppConstants.service!.title,
                style: TextStyle(
                  fontSize: R.F(context, 18),
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                const MoreInfoIcon(),
                SizedBox(
                  width: R.sW(context, 15),
                )
              ],
             
            ),
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
                  child:  Text(
                    'set_the_name_of_car_and_model_you_want_to_wash'.tr(),
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: R.F(context, 16),
                        fontWeight: FontWeight.w500
                      ),
                  ),
                ),
                DropDownCarWash(
                    dropDownHint: 'Car Type'.tr(),
                    selectedItem: selectedCarType,
                    dropDownItems: carType,
                    dropDownTitle: 'Car Type'.tr()),
                DropDownCarWash(
                    dropDownHint: 'Car Model'.tr(),
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
        });
  }
}
