import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_login_button.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/custom_text_field.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_car.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_state.dart';

class MyBottomSheet extends StatefulWidget {
  final bool isEdit;
  const MyBottomSheet({
    required this.isEdit,
    super.key,
  });

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  String? selectedCarType;
  int selectedColorIndex = 0;
  bool isCarTypeValid = false;
  final formKey = GlobalKey<FormState>();
  late TextEditingController carModelController;
  late TextEditingController carNameController;
  late TextEditingController carNumberController1;
  late TextEditingController carNumberController2;

  @override
  void initState() {
    if (!widget.isEdit) {
      ServiceCubit.get(context).getCompanies(1, AppConstants.addressID);
      ServiceCubit.get(context).getColors(AppConstants.addressID);
    } else {
      ServiceCubit.get(context).showCar(AppConstants.selectEdit!);
    }
    ServiceCubit.get(context).getColors(AppConstants.addressID);

    super.initState();
  }

  @override
  void dispose() {
    carNameController.dispose();
    carModelController.dispose();
    carNumberController1.dispose();
    carNumberController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> addCar() async {
      if (formKey.currentState!.validate()) {
        ServiceCubit.get(context).createCar(
          CarParams(
              name: carNameController.text,
              companyId: ServiceCubit.get(context)
                  .companies!
                  .firstWhere((element) => element.name == selectedCarType)
                  .id!,
              plate: carNumberController1.text + carNumberController2.text,
              colorID:
                  ServiceCubit.get(context).colors![selectedColorIndex].id!,
              carModelId: 1),
        );
      }
    }

    Future<void> updateCar() async {
      if (formKey.currentState!.validate()) {
        ServiceCubit.get(context).updateCar(
            CarParams(
                name: carNameController.text,
                companyId: ServiceCubit.get(context).car!.company!.id!,
                plate: carNumberController1.text + carNumberController2.text,
                colorID:
                    ServiceCubit.get(context).colors![selectedColorIndex].id!,
                carModelId: 1),
            AppConstants.selectEdit!);
      }
    }

    return BlocConsumer<ServiceCubit, ServiceStates>(
        listener: (context, state) {
      if (state is CreateCarLoaded) {
        ServiceCubit.get(context).getCars(1);
        Navigator.pop(context);
      }
      if (widget.isEdit ? state is ShowCarLoaded : true) {
        carModelController = widget.isEdit
            ? TextEditingController(
                text: ServiceCubit.get(context).car!.car!.name)
            : TextEditingController();
        carNameController = widget.isEdit
            ? TextEditingController(text: ServiceCubit.get(context).car!.name)
            : TextEditingController();
        carNumberController1 = widget.isEdit
            ? TextEditingController(
                text: ServiceCubit.get(context).car!.plate!.substring(0, 3))
            : TextEditingController();
        carNumberController2 = widget.isEdit
            ? TextEditingController(
                text: ServiceCubit.get(context).car!.plate!.substring(3, 7))
            : TextEditingController();
        selectedColorIndex = widget.isEdit
            ? ServiceCubit.get(context).colors!.indexWhere((element) =>
                element.id == ServiceCubit.get(context).car!.color!.id!)
            : 0;
      }
    }, builder: (context, state) {
      if (widget.isEdit
          ? ServiceCubit.get(context).car == null
          : state is GetCompaniesLoading || state is GetColorsLoading) {
        return SizedBox(
          height: R.sH(context, 600),
          child: Center(
            child: CircularIndicator(
              color: AppColors.darkBlue,
            ),
          ),
        );
      }
      return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: R.sW(context, 20),
            right: R.sW(context, 20),
            top: R.sH(context, 20)),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text('add_car'.tr(),
                    style: TextStyle(
                        fontSize: R.F(
                          context,
                          20,
                        ),
                        fontWeight: FontWeight.w600)),
                SizedBox(height: R.sH(context, 20)),
                SizedBox(
                  height: R.sH(context, 120),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('car_type'.tr(),
                                style: TextStyle(
                                    fontSize: R.F(
                                      context,
                                      18,
                                    ),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkBlue)),
                            SizedBox(height: R.sH(context, 5)),
                            widget.isEdit
                                ? Container(
                                    width: double.infinity,
                                    height: R.sH(context, 55),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: R.sW(context, 5),
                                        vertical: R.sH(context, 5)),
                                    decoration: BoxDecoration(
                                      color: AppColors.grey1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        ServiceCubit.get(context)
                                            .car!
                                            .company!
                                            .name!,
                                        style: TextStyle(
                                            color: AppColors.darkBlue,
                                            fontSize: R.F(context, 16)),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: R.sW(context, 5),
                                        vertical: R.sH(context, 5)),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: AppColors.grey),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: selectedCarType,
                                        hint: Text("select".tr(),
                                            style: TextStyle(
                                                color: AppColors.grey)),
                                        items: ServiceCubit.get(context)
                                            .companies!
                                            .map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value.name,
                                            child: Text(value.name!),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedCarType = newValue;
                                            isCarTypeValid = true;
                                          });
                                        },
                                      ),
                                    )),
                          ],
                        ),
                      ),
                      SizedBox(width: R.sW(context, 5)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('car_model'.tr(),
                                style: TextStyle(
                                    fontSize: R.F(
                                      context,
                                      18,
                                    ),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkBlue)),
                            SizedBox(height: R.sH(context, 5)),
                            widget.isEdit
                                ? Container(
                                    width: double.infinity,
                                    height: R.sH(context, 55),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: R.sW(context, 5),
                                        vertical: R.sH(context, 5)),
                                    decoration: BoxDecoration(
                                      color: AppColors.grey1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        ServiceCubit.get(context)
                                            .car!
                                            .car!
                                            .name!,
                                        style: TextStyle(
                                            color: AppColors.darkBlue,
                                            fontSize: R.F(context, 16)),
                                      ),
                                    ),
                                  )
                                : BottomTextFeild(
                                    controller: carModelController,
                                    keyboardType: TextInputType.text,
                                    labelText: 'car_model'.tr(),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter car model';
                                      }
                                      return null;
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: R.sH(context, 20)),
                SizedBox(
                  height: R.sH(context, 120),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('car_name'.tr(),
                                style: TextStyle(
                                    fontSize: R.F(
                                      context,
                                      18,
                                    ),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkBlue)),
                            SizedBox(height: R.sH(context, 5)),
                            BottomTextFeild(
                              controller: carNameController,
                              keyboardType: TextInputType.text,
                              labelText: 'car_name'.tr(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter car name';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: R.sW(context, 5)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('car_number'.tr(),
                                style: TextStyle(
                                    fontSize: R.F(
                                      context,
                                      18,
                                    ),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkBlue)),
                            SizedBox(height: R.sH(context, 5)),
                            Row(
                              children: [
                                Expanded(
                                  child: BottomTextFeild(
                                    controller: carNumberController1,
                                    keyboardType: TextInputType.text,
                                    labelText: 'G N S',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'fill'.tr();
                                      } else if (value.length != 3) {
                                        return 'wrong'.tr();
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(width: R.sW(context, 5)),
                                Expanded(
                                  child: BottomTextFeild(
                                    controller: carNumberController2,
                                    keyboardType: TextInputType.number,
                                    labelText: '2 1 4 5',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'fill'.tr();
                                      } else if (value.length != 4 ||
                                          int.tryParse(value) == null) {
                                        return 'wrong'.tr();
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: R.sH(context, 20)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('car_color'.tr(),
                      style: TextStyle(
                          fontSize: R.F(
                            context,
                            18,
                          ),
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkBlue)),
                ),
                SizedBox(height: R.sH(context, 5)),
                BlocBuilder<ServiceCubit, ServiceStates>(
                  builder: (context, state) {
                    if (state is GetColorsLoading) {
                      return CircularIndicator(
                        color: AppColors.darkBlue,
                      );
                    } else {
                      return SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ServiceCubit.get(context).colors!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedColorIndex = index;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: R.sW(context, 5)),
                                child: Container(
                                  width: selectedColorIndex == index ? 50 : 35,
                                  height: selectedColorIndex == index ? 50 : 35,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        ServiceCubit.get(context)
                                            .colors![index]
                                            .media!
                                            .url!,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: R.sH(context, 40)),
                CustomLoginButton(
                  text: widget.isEdit ? "update_car".tr() : "add_car".tr(),
                  onPressed: widget.isEdit ? updateCar : addCar,
                  isLoading: state is CreateCarLoading,
                ),
                SizedBox(height: R.sH(context, 10)),
              ],
            ),
          ),
        ),
      );
    });
  }
}
