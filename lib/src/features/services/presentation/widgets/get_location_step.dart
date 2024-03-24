import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/dotted_check_box.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/services/domain/entities/adresses.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_state.dart';

class LocationStep extends StatefulWidget {
  const LocationStep({super.key});

  @override
  State<LocationStep> createState() => _LocationStepState();
}

class _LocationStepState extends State<LocationStep> {
  late final ScrollController _scrollController;
  int nextPage = 2;
  bool isLoading = false;
  @override
  initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() async {
      if (nextPage <= ServiceCubit.get(context).metaAddresses!.lastPage) {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8) {
          if (!isLoading) {
            isLoading = true;
            await context.read<ServiceCubit>().getAdresses(nextPage++);
            isLoading = false;
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceStates>(
      listener: (context, state) {
        if (state is GetAddressesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('error'.tr()),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        List<Address>? address = context.read<ServiceCubit>().addresses;
        if (state is GetAddressesLoading && address!.isEmpty) {
          return SizedBox(
            height: R.sH(context, 500),
            child: Center(
              child: CircularIndicator(
                color: AppColors.darkBlue,
              ),
            ),
          );
        } else if (state is GetAddressesError) {
          return const SizedBox.shrink();
        }
        return SizedBox(
          height: R.sH(context, 500),
          child: ListView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            children: [
              address!.isEmpty
                  ? Center(
                      child: Text(
                        'you_dont_have_any_added_address'.tr(),
                        style: TextStyle(
                            fontSize: R.F(context, 14),
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey),
                      ),
                    )
                  : const SizedBox.shrink(),
              SizedBox(height: R.sH(context, 20)),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: address.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context
                                .read<ServiceCubit>()
                                .selectAddressIndex(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.white,
                              border: Border.all(
                                color: AppColors.darkBlue,
                                width: R.sW(context, 1),
                              ),
                            ),
                            padding: EdgeInsets.all(R.sW(context, 10)),
                            child: Container(
                              padding: EdgeInsets.all(R.sW(context, 10)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.grey1!,
                              ),
                              child: Row(
                                children: [
                                  CustomPaint(
                                    size: Size(
                                        R.sW(context, 16), R.sW(context, 16)),
                                    painter: DottedCirclePainter(
                                      isChecked: context
                                              .read<ServiceCubit>()
                                              .selectedAddressIndex ==
                                          index,
                                    ),
                                  ),
                                  SizedBox(width: R.sW(context, 15)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/home.svg',
                                            width: R.sW(context, 15),
                                            height: R.sH(context, 15),
                                            color: AppColors.black,
                                          ),
                                          SizedBox(width: R.sW(context, 2)),
                                          Text(address[index].name!,
                                              style: TextStyle(
                                                fontSize: R.F(context, 16),
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: AppColors.black,
                                            size: R.sW(context, 20),
                                          ),
                                          SizedBox(width: R.sW(context, 2)),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(address[index].city!,
                                                  style: TextStyle(
                                                    fontSize: R.F(context, 14),
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                              SizedBox(
                                                width: R.sW(context, 180),
                                                child: Text(
                                                    address[index].address!,
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize:
                                                          R.F(context, 14),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Icon(Icons.arrow_forward_ios,
                                      color: AppColors.grey),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: R.sH(context, 10)),
                      ],
                    );
                  }),
              SizedBox(height: R.sH(context, 20)),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.location,
                      arguments: false);
                },
                child: FullRounderContainer(
                  title: "add_new_address".tr(),
                  containerColor: AppColors.white,
                  textColor: AppColors.darkBlue,
                  circular: 30,
                ),
              ),
              SizedBox(height: R.sH(context, 10)),
            ],
          ),
        );
      },
    );
  }
}
