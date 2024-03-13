import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/no_available_data.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';
import 'package:schmitt/src/features/home/presentation/widgets/service_item.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AllServicesScreen extends StatefulWidget {
  final String query;
  const AllServicesScreen({Key? key, required this.query}) : super(key: key);

  @override
  State<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getServicesAndMatch(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          if (state is ServicesLoading) {
            return Center(
              child: CircularIndicator(
                color: AppColors.darkBlue,
              ),
            );
          } else if (state is ServicesLoaded) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(R.sW(context, 20)),
                child: state.services!.isEmpty
                    ? SizedBox(
                        height: R.H(context),
                        child: const NoDataAvailable(
                          text: 'no_servcies_with_this_name',
                        ),
                      )
                    : AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: state.services!.length,
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
                        child: ServiceItem(services: state.services![index]),
                      ),
                    ),
                  );
                },
              ),
            ),
              ),
            );
          } else if (state is ServicesError) {
            return Text('Error: ${state.message}');
          } else {
            return const NoDataAvailable(
              text: 'no_servcies_with_this_name',
            );
          }
        },
      ),
    );
  }
}
