import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/widgets/network_image.dart';
import 'package:schmitt/src/features/inbox/domain/entities/call.dart';

class CallContainerTile extends StatelessWidget {
  final Call chatContact;

  const CallContainerTile({super.key, required this.chatContact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: R.sW(context, 5), vertical: R.sH(context, 12)),
      child: Row(
        children: [
          SizedBox(
            height: 35,
            width: 35,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: NetworkImageWidget(
                borderRadiusImageFile: 50,
                imageFileBoxFit: BoxFit.cover,
                placeHolderBoxFit: BoxFit.cover,
                networkImageBoxFit: BoxFit.cover,
                imageUrl: chatContact.receiverPic,
                progressIndicatorBuilder: Center(
                  child: CircularIndicator(
                    color: AppColors.darkBlue,
                  ),
                ),
                placeHolder: 'assets/images/profile-photo.svg',
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
                  chatContact.receiverName,
                  style: TextStyle(
                    fontSize: R.F(context, 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: R.sH(context, 3),
                ),
                Text(
                  chatContact.receiverId,
                  style: TextStyle(
                    fontSize: R.F(context, 14),
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
