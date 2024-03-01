import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_login_button.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_car.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_state.dart';

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({super.key});

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  String? selectedCarType;
  int selectedColorIndex = 0;
  bool isCarTypeValid = false;
  final formKey = GlobalKey<FormState>();
  final carNameController = TextEditingController();
  final carNumberController1 = TextEditingController();
  final carNumberController2 = TextEditingController();

  @override
  void initState() {
    ServiceCubit.get(context).getCompanies(1, AppConstants.addressID);
    ServiceCubit.get(context).getColors(AppConstants.addressID);
    super.initState();
  }

  @override
  void dispose() {
    carNameController.dispose();
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

    return BlocConsumer<ServiceCubit, ServiceStates>(
        listener: (context, state) {
      if (state is CreateCarLoaded) {
        ServiceCubit.get(context).getCars(1);
        Navigator.pop(context);
      }
    }, builder: (context, state) {
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
                Row(
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
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: R.sW(context, 5),
                                  vertical: R.sH(context, 5)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.grey),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedCarType,
                                  hint: Text("select".tr(),
                                      style: TextStyle(color: AppColors.grey)),
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
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: R.sW(context, 5),
                                vertical: R.sH(context, 5)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.grey),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text("select".tr(),
                                    style: TextStyle(color: AppColors.grey)),
                                items: <String>[
                                  'Option 1',
                                  'Option 2',
                                  'Option 3'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: R.sH(context, 20)),
                Row(
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
                          Container(
                            width: double.infinity,
                            height: R.sH(context, 60),
                            padding: EdgeInsets.symmetric(
                                horizontal: R.sW(context, 5),
                                vertical: R.sH(context, 5)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.grey),
                            ),
                            child: TextFormField(
                              controller: carNameController,
                              decoration: InputDecoration(
                                hintText: 'car_name'.tr(),
                                hintStyle: TextStyle(color: AppColors.grey),
                                border: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter car name';
                                }
                                return null;
                              },
                            ),
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
                                child: Container(
                                  width: double.infinity,
                                  height: R.sH(context, 60),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: R.sW(context, 5),
                                      vertical: R.sH(context, 5)),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppColors.grey),
                                  ),
                                  child: TextFormField(
                                    controller: carNumberController1,
                                    decoration: InputDecoration(
                                      hintText: "G N S",
                                      hintStyle:
                                          TextStyle(color: AppColors.grey),
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.center,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter car number';
                                      } else if (value.length != 3) {
                                        return 'Car number must be exactly 3 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: R.sW(context, 5)),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: R.sH(context, 60),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: R.sW(context, 5),
                                      vertical: R.sH(context, 5)),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppColors.grey),
                                  ),
                                  child: TextFormField(
                                    controller: carNumberController2,
                                    decoration: InputDecoration(
                                      hintText: "2 1 4 5",
                                      hintStyle:
                                          TextStyle(color: AppColors.grey),
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                    ),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter car number';
                                      } else if (value.length != 4 ||
                                          int.tryParse(value) == null) {
                                        return 'Car number must be exactly 4 digits';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
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
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: selectedColorIndex == index
                                        ? Border.all(
                                            color: AppColors.darkBlue, width: 4)
                                        : null,
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
                  text: "add_car".tr(),
                  onPressed: addCar,
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
