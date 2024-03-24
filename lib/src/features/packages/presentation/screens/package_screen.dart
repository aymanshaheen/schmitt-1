import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/error/response_status.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors_dark.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/no_available_data.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/core/widgets/snakbar_builder.dart';
import 'package:schmitt/src/features/packages/domain/entities/package_entity.dart';
import 'package:schmitt/src/features/packages/presentation/cubit/package_cubit.dart';
import 'package:schmitt/src/features/packages/presentation/widgets/packages_app_bar.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  late final ScrollController _scrollController;
  int nextPage = 2;
  bool isLoading = false;
  @override
  void initState() {
    if (PackageCubit.get(context).packages.isEmpty) {
      PackageCubit.get(context).getPackages(1);
    }
    _scrollController = ScrollController();
    _scrollController.addListener(() async {
      if (nextPage <= PackageCubit.get(context).metaPackages!.lastPage) {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8) {
          if (!isLoading) {
            isLoading = true;
            await context.read<PackageCubit>().getPackages(nextPage++);
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
      backgroundColor: Colors.grey[100],
      appBar: packageAppBar(context: context, title: 'packages'.tr()),
      body:
          BlocConsumer<PackageCubit, PackageStates>(listener: (context, state) {
        if (state is PacakgesError &&
                state.message ==
                    DataSource.networkConnectError.getFailure().message ||
            state is PacakgesError &&
                state.message ==
                    DataSource.connectionTimeout.getFailure().message) {
          buildSnakBar(
              context: context, message: state.message, color: AppColors.error);
        }
      }, builder: (context, state) {
        List<PackageDataEntity> package = PackageCubit.get(context).packages;
        if (state is PacakgesLoading) {
          return Center(child: CircularIndicator(color: AppColors.darkBlue));
        }
        if (state is PacakgesLoaded && package.isEmpty) {
          return Center(
            child: NoDataAvailable(
              text: "there_is_no_added_packages_yet".tr(),
            ),
          );
        } else if (state is PacakgesError &&
                state.message ==
                    DataSource.networkConnectError.getFailure().message ||
            state is PacakgesError &&
                state.message ==
                    DataSource.connectionTimeout.getFailure().message) {
          return NoDataAvailable(
              text: "check_your_internet_connection_please".tr());
        }
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: R.sW(context, 15),
            vertical: R.sH(context, 5),
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: package.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: const Duration(milliseconds: 100),
                  child: SlideAnimation(
                    duration: const Duration(milliseconds: 2500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    verticalOffset: -250,
                    child: ScaleAnimation(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: Padding(
                          padding: EdgeInsets.only(bottom: R.sW(context, 10)),
                          child: Container(
                            padding: EdgeInsets.all(R.sW(context, 10)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: R.sW(context, 320),
                                  height: R.sH(context, 55),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 241, 243, 129),
                                        Color.fromARGB(255, 251, 238, 116),
                                        Color.fromARGB(255, 237, 217, 40),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      package[index].name!,
                                      style: TextStyle(
                                        color: AppColorsDark.darkBlue,
                                        fontSize: R.F(context, 16),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: R.sW(context, 10)),
                                Container(
                                  width: R.sW(context, 320),
                                  height: R.sH(context, 120),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://via.placeholder.com/150",
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                SizedBox(height: R.sH(context, 10)),
                                Text(
                                  'details_of_package'.tr(),
                                  style: TextStyle(
                                    color: AppColors.darkBlue,
                                    fontSize: R.F(context, 18),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: R.sH(context, 5)),
                                ExpandableText(
                                  package[index].description!,
                                  expandText: 'Read more',
                                  collapseText: 'show less',
                                  maxLines: 4,
                                  linkColor: AppColors.darkBlue,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: R.F(context, 16),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: R.sH(context, 10)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(width: R.sH(context, 10)),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          color: AppColors.grey,
                                        ),
                                        SizedBox(width: R.sH(context, 5)),
                                        Text(
                                          package[index].days!.toString() +
                                              ' ' +
                                              'days'.tr(),
                                          style: TextStyle(
                                            color: AppColors.darkBlue,
                                            fontSize: R.F(context, 16),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.menu,
                                          color: AppColors.grey,
                                        ),
                                        SizedBox(width: R.sH(context, 5)),
                                        Text(
                                          package[index].days!.toString() +
                                              ' ' +
                                              'times'.tr(),
                                          style: TextStyle(
                                            color: AppColors.darkBlue,
                                            fontSize: R.F(context, 16),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: R.sH(context, 10)),
                                  ],
                                ),
                                Divider(
                                  color: AppColors.grey1,
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'price'.tr() + ' : ',
                                      style: TextStyle(
                                        color: AppColors.darkBlue,
                                        fontSize: R.F(context, 18),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: R.sW(context, 5)),
                                    Text(
                                      package[index].price!.toString() + "\$",
                                      style: TextStyle(
                                        color: AppColors.green,
                                        fontSize: R.F(context, 16),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: R.sW(context, 5)),
                                    Text(
                                      package[index].discountPrice!.toString() +
                                          "\$",
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: R.F(context, 16),
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: R.sH(context, 15)),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.packageDetailsScreen,
                                        arguments: package[index]);
                                  },
                                  child: FullRounderContainer(
                                      title: "susbcribe_now".tr(),
                                      containerColor: AppColors.darkBlue,
                                      textColor: AppColors.white,
                                      circular: 30),
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
