import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/packages/presentation/cubit/package_cubit.dart';
import 'package:schmitt/src/features/packages/presentation/widgets/display_stars.dart';
import 'package:visibility_detector/visibility_detector.dart';

class DisplayRating extends StatefulWidget {
  const DisplayRating({super.key});

  @override
  State<DisplayRating> createState() => _DisplayRatingState();
}

class _DisplayRatingState extends State<DisplayRating>
    with TickerProviderStateMixin {
  late final AnimationController _controller,
      _controller1,
      _controller2,
      _controller3;
  late final Animation<double> _animation,
      _animation1,
      _animation2,
      _animation3;

@override
void initState() {
  super.initState();
  _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  _controller1 = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  _animation1 = CurvedAnimation(
    parent: _controller1,
    curve: Curves.easeInOut,
  );

  _controller2 = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  _animation2 = CurvedAnimation(
    parent: _controller2,
    curve: Curves.easeInOut,
  );

  _controller3 = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  _animation3 = CurvedAnimation(
    parent: _controller3,
    curve: Curves.easeInOut,
  );
}
  @override
  void dispose() {
    _controller.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, double> reviewCounts = PackageCubit.get(context).getReviewCounts();
    double totalCount = reviewCounts.values.reduce((a, b) => a + b);
    return VisibilityDetector(
    key: const Key('unique key'),
    onVisibilityChanged: (VisibilityInfo info) {
      if (info.visibleFraction >0) {
        _controller.forward();
        _controller1.forward();
        _controller2.forward();
        _controller3.forward();
      }
    },
      child: BlocBuilder<PackageCubit, PackageStates>(
        builder: (context, state) {
          if (PackageCubit.get(context).reviews!.isEmpty) {
            return const SizedBox.shrink();
          }
          return Column(
            children: [
              SizedBox(
                height: R.sH(context, 10),
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget? child) {
                  return Center(
                    child: Text(
                      (_animation.value *
                              PackageCubit.get(context).getAverageRating())
                          .toStringAsFixed(1),
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: R.F(context, 28),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
              StarDisplay(value: PackageCubit.get(context).getAverageRating()),
              SizedBox(
                height: R.sH(context, 10),
              ),
              Center(
                child: AnimatedBuilder(
                  animation: _animation1,
                  builder: (BuildContext context, Widget? child) {
                    return Text(
                      '(' +
                          (_animation1.value *
                                  PackageCubit.get(context).reviews!.length)
                              .round()
                              .toString() +
                          ') ' +
                          "there_is_50_user_have_rated_this_package".tr(),
                      style: TextStyle(
                        color: AppColors.lightGrey,
                        fontSize: R.F(context, 18),
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: R.sH(context, 190),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reviewCounts.length,
                  itemBuilder: (context, index) {
                    int rating = reviewCounts.keys.elementAt(index);
                    double count = reviewCounts[rating]!;
                    double percentage = (count / totalCount) * 100;
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: R.sW(context, 10),
                          vertical: R.sH(context, 5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: R.sW(context, 43),
                            child: Text(
                              '$rating ' + 'stars'.tr(),
                              style: TextStyle(
                                color: AppColors.lightGrey,
                                fontSize: R.F(context, 14),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                width: R.sW(context, 220),
                                height: R.sH(context, 20),
                                decoration: BoxDecoration(
                                  color: AppColors.grey1,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              AnimatedBuilder(
                                animation: _animation2,
                                builder: (BuildContext context, Widget? child) {
                                  return Container(
                                    width: R.sW(context, 220) *
                                        _animation2.value *
                                        (count / totalCount),
                                    height: R.sH(context, 20),
                                    decoration: BoxDecoration(
                                      color: AppColors.black,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          AnimatedBuilder(
                            animation: _animation3,
                            builder: (BuildContext context, Widget? child) {
                              return SizedBox(
                                width: R.sW(context, 45),
                                child: Text(
                                  (_animation3.value * percentage)
                                          .toStringAsFixed(1) +
                                      '%',
                                  style: TextStyle(
                                    color: AppColors.lightGrey,
                                    fontSize: R.F(context, 14),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
