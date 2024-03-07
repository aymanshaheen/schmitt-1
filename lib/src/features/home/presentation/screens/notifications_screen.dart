import 'package:easy_localization/easy_localization.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/core/widgets/snakbar_builder.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'notifications'.tr(),
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        leadingWidth: R.sW(context, 15),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () {
              HomeCubit.get(context).markAllSeen();
            },
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: R.sH(context, 17)),
              child: const MoreInfoIcon()),
          SizedBox(
            width: R.sW(context, 15),
          )
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is MarkAllSeenLoaded) {
            buildSnakBar(
                context: context,
                message: state.message,
                color: AppColors.green);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: R.sW(context, 20), vertical: R.sH(context, 10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today",
                    style: TextStyle(
                      color: AppColors.homeBlackColor,
                      fontSize: R.F(context, 16),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  ListView.builder(
                    itemCount: 4,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(index.toString()),
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {},
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: R.sW(context, 15),
                              right: R.sW(context, 15),
                              bottom: R.sH(context, 10),
                              top: R.sH(context, 10)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: R.sW(context, 30),
                                backgroundColor: AppColors.darkBlue,
                                child: SvgPicture.asset(
                                  AppImage.pocket,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: R.sW(context, 10),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Payment Successful",
                                    style: TextStyle(
                                      color: AppColors.homeBlackColor,
                                      fontSize: R.F(context, 16),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: R.sH(context, 5),
                                  ),
                                  SizedBox(
                                    width: R.sW(context, 220),
                                    child: ExpandableText(
                                      "Your payment of 1000 has been successfully completed",
                                      expandText: 'Read more',
                                      collapseText: 'show less',
                                      maxLines: 4,
                                      linkColor: AppColors.darkBlue,
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: R.F(context, 14),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
