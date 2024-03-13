import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';
import 'package:schmitt/src/features/home/presentation/widgets/service_item.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ServicetypeScreen extends StatefulWidget {
  final String serviceName;
  final String services;
  const ServicetypeScreen(
      {super.key, required this.services, required this.serviceName});

  @override
  State<ServicetypeScreen> createState() => _ServicetypeScreenState();
}

class _ServicetypeScreenState extends State<ServicetypeScreen> {
  @override
  void initState() {
    HomeCubit.get(context).getCategoryServices(1,  widget.services);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          widget.serviceName,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        leadingWidth: R.sW(context, 15),
       
      ),
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
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
                padding: EdgeInsets.symmetric(
                    horizontal: R.sW(context, 20), vertical: R.sH(context, 10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
  itemCount: state.services!.length,
  physics: const NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  itemBuilder: (context, index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      delay: const Duration(milliseconds: 100),
      child: SlideAnimation(
        duration:const Duration(milliseconds: 2500),
        curve: Curves.fastLinearToSlowEaseIn,
        verticalOffset: -250,
        child: ScaleAnimation(
          duration:const Duration(milliseconds: 1500),
          curve: Curves.fastLinearToSlowEaseIn,
          child: InkWell(
            onTap: () => Navigator.pushNamed(
              context, Routes.service,
              arguments: state.services![index]
            ),
            child: ServiceItem(
              services: state.services![index],
            ),
          ),
        ),
      ),
    );
  },
),
                  ],
                ),
              ),
            );
          } else if (state is ServicesError) {
            return const Center(
              child: Text('Error loading services'),
            );
          }
          return const Center(
            child: Text('there is no services available at the moment'),
          );
        },
      ),
    );
  }
}
