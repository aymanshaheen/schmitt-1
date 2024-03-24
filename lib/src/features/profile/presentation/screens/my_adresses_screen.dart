import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/error/response_status.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/no_available_data.dart';
import 'package:schmitt/src/core/widgets/snakbar_builder.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/address_item.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_state.dart';
import '../../../../core/widgets/responsivity.dart';

class MyAddressesScreen extends StatefulWidget {
  const MyAddressesScreen({super.key});

  @override
  State<MyAddressesScreen> createState() => _CarWashScreenState();
}

class _CarWashScreenState extends State<MyAddressesScreen> {
  late final ScrollController _scrollController;
  int nextPage = 2;
  bool isLoading = false;
  @override
  void initState() {
    if(ServiceCubit.get(context).addresses!.isEmpty){
      ServiceCubit.get(context).getAdresses(1);
    }
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          centerTitle: false,
          leadingWidth: R.sW(context, 15),
          automaticallyImplyLeading: false,
          title: Text(
            'my_places'.tr(),
            style: TextStyle(
              color: AppColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.white,
          elevation: 0,
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: R.sW(context, 20), vertical: R.sH(context, 20)),
            child: BlocConsumer<ServiceCubit, ServiceStates>(
                listener: (context, state) {
              if (state is GetAddressesError &&
                      state.message ==
                          DataSource.networkConnectError.getFailure().message ||
                  state is GetAddressesError &&
                      state.message ==
                          DataSource.connectionTimeout.getFailure().message) {
                buildSnakBar(
                    context: context,
                    message: state.message,
                    color: AppColors.error);
              }
            }, builder: (context, state) {
              if (state is GetAddressesLoading) {
                return SizedBox(
                  height: R.sH(context, 600),
                  child: Center(
                    child: CircularIndicator(
                      color: AppColors.darkBlue,
                    ),
                  ),
                );
              }
              return BlocConsumer<ServiceCubit, ServiceStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetAddressesLoading) {
                    return SizedBox(
                      height: R.sH(context, 600),
                      child: Center(
                        child: CircularIndicator(
                          color: AppColors.darkBlue,
                        ),
                      ),
                    );
                  } else if (state is GetAddressesLoaded ||
                      ServiceCubit.get(context).addresses!.isNotEmpty) {
                    return SingleChildScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.location,
                                  arguments: false);
                            },
                            child: FullRounderContainer(
                              title: 'add_new_address'.tr(),
                              containerColor: AppColors.darkBlue,
                              textColor: AppColors.white,
                              circular: 20,
                            ),
                          ),
                          SizedBox(
                            height: R.sH(context, 20),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                ServiceCubit.get(context).addresses!.length +
                                    (isLoading ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index <
                                  ServiceCubit.get(context).addresses!.length) {
                                return AddressItem(
                                  services: ServiceCubit.get(context)
                                      .addresses![index],
                                );
                              } else {
                                return Center(
                                    child: CircularIndicator(
                                        color: AppColors.darkBlue));
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  } else if (state is GetAddressesError &&
                      state.message ==
                          DataSource.networkConnectError.getFailure().message ||
                  state is GetAddressesError &&
                      state.message ==
                          DataSource.connectionTimeout.getFailure().message) {
                    return const NoDataAvailable(
                        text: "check_your_internet_connection_please");
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: R.sH(context, 100),
                        ),
                        SvgPicture.asset(
                          AppImage.error,
                          fit: BoxFit.cover,
                          width: R.sW(context, 200),
                          height: R.sH(context, 200),
                        ),
                        SizedBox(
                          height: R.sH(context, 50),
                        ),
                        Text(
                          'you_dont_have_any_added_address'.tr(),
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: R.sH(context, 150),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.location,
                                arguments: false);
                          },
                          child: FullRounderContainer(
                            title: 'add_new_address'.tr(),
                            containerColor: AppColors.darkBlue,
                            textColor: AppColors.white,
                            circular: 20,
                          ),
                        )
                      ],
                    );
                  }
                },
              );
            })));
  }
}
