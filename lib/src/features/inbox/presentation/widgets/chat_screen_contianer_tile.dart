import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/widgets/network_image.dart';
import 'package:schmitt/src/features/inbox/domain/entities/contact_chat.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/contact_profile_pic_dialog.dart';

class ChatContainerTile extends StatelessWidget {
  final ContactChat chatContact;

  const ChatContainerTile({super.key, required this.chatContact});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream:
            ChatCubit.get(context).numOfMessageNotSeen(chatContact.contactId),
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: R.sW(context, 5), vertical: R.sH(context, 12)),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.chat, arguments: {
                  'name': chatContact.name,
                  'id': chatContact.contactId,
                });
              },
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      showContactProfilePicDialog(
                        context,
                        contact: chatContact,
                      );
                    },
                    child: SizedBox(
                      height: 35,
                      width: 35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: NetworkImageWidget(
                          borderRadiusImageFile: 50,
                          imageFileBoxFit: BoxFit.cover,
                          placeHolderBoxFit: BoxFit.cover,
                          networkImageBoxFit: BoxFit.cover,
                          imageUrl: chatContact.profilePic,
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
                  SizedBox(
                    width: R.sW(context, 10),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatContact.name,
                          style: TextStyle(
                            fontSize: R.F(context, 16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: R.sH(context, 3),
                        ),
                        Text(
                          chatContact.lastMessage,
                          style: TextStyle(
                            fontSize: R.F(context, 14),
                            color: AppColors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: R.sW(context, 10),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (snapshot.data != 0)
                        Container(
                          width: R.sW(context, 20),
                          height: R.sH(context, 20),
                          decoration: BoxDecoration(
                            color: AppColors.darkBlue,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Text(
                              snapshot.data.toString(),
                              style: TextStyle(
                                fontSize: R.F(context, 12),
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: R.sH(context, 8),
                      ),
                      Text(
                        DateFormat('hh:mm a').format(chatContact.timeSent),
                        style: TextStyle(
                          fontSize: R.F(context, 12),
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
