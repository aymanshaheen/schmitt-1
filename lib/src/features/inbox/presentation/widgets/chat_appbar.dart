import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/models/pop_up_menu_item_model.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';
import 'package:schmitt/src/features/home/presentation/widgets/network_image.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/call_cubit/call_cubit.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/custom_pop_up_menu_button.dart';

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String name;
  final String receiverId;

  const ChatAppBar({
    Key? key,
    required this.name,
    required this.receiverId,
  }) : super(key: key);

  @override
  _ChatAppBarState createState() => _ChatAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ChatAppBarState extends State<ChatAppBar> {
  late Stream<UserEntity> userStream;

  @override
  void initState() {
    super.initState();
    userStream = HomeCubit.get(context).getUserById(widget.receiverId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
      return StreamBuilder<UserEntity>(
          stream: userStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularIndicator(
                color: AppColors.darkBlue,
              );
            }
            UserEntity userdata = snapshot.data!;
            return AppBar(
              leadingWidth: R.sW(context, 90),
              titleSpacing: 0,
              backgroundColor: AppColors.white,
              elevation: 0.5,
              leading: Container(
                margin: EdgeInsets.only(
                  bottom: R.sH(context, 10),
                  left: R.sW(context, 10),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios),
                      SizedBox(
                        width: R.sW(context, 3),
                      ),
                      Hero(
                        tag: userdata.id!,
                        child: SizedBox(
                          height: 45,
                          width: 45,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: NetworkImageWidget(
                              borderRadiusImageFile: 50,
                              imageFileBoxFit: BoxFit.cover,
                              placeHolderBoxFit: BoxFit.cover,
                              networkImageBoxFit: BoxFit.cover,
                              imageUrl: userdata.avatar,
                              progressIndicatorBuilder: Center(
                                child: CircularIndicator(
                                  color: AppColors.darkBlue,
                                ),
                              ),
                              placeHolder: 'assets/images/profile-photo.svg',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              title: SizedBox(
                width: double.infinity,
                height: kToolbarHeight,
                child: InkWell(
                  onTap: () {
                    // to user profile screen
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: R.F(context, 16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                BlocConsumer<CallCubit, CallState>(
                  listener: (context, state) {
                    if (state is MakeCallSuccessState) {
                      Navigator.pushNamed(
                        context,
                        Routes.callRoute,
                        arguments: {
                          'call': state.call,
                          'channelId': state.call.callId,
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        CallCubit.get(context).makeCall(
                          receiverId: widget.receiverId,
                          receiverName: widget.name,
                          receiverPic: userdata.avatar!,
                        );
                      },
                      child: SvgPicture.asset(
                        AppImage.call,
                        height: R.sH(context, 20),
                        width: R.sW(context, 20),
                        color: AppColors.darkBlue,
                      ),
                    );
                  },
                ),
                CustomPopUpMenuButton(
                  buttons: _buttons(context),
                ),
              ],
            );
          });
    });
  }

  List<PopUpMenuItemModel> _buttons(context) => [
        PopUpMenuItemModel(
          name: AppStrings.search,
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: AppStrings.search,
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: AppStrings.search,
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: AppStrings.search,
          onTap: () {},
        ),
      ];


}