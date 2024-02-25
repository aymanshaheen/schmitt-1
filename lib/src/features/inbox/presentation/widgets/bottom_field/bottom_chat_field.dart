import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/app_size.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/inbox/domain/entities/message_replay.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/message_content/message_replay_preview.dart';

class BottomChatField extends StatelessWidget {
  final TextEditingController messageController;
  final FocusNode focusNode;
  final Function(String) onTextFieldValueChanged;
  final String receiverId;

  const BottomChatField({
    super.key,
    required this.messageController,
    required this.focusNode,
    required this.onTextFieldValueChanged,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: R.sW(context, 300),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        children: [
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              MessageReplay? messageReplay =
                  ChatCubit.get(context).messageReplay;
              if (messageReplay == null) {
                return const SizedBox();
              }
              return MessageReplayPreview(
                messageReplay: messageReplay,
              );
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  constraints: BoxConstraints(maxHeight: R.sH(context, 120)),
                  child: TextField(
                    onChanged: onTextFieldValueChanged,
                    controller: messageController,
                    cursorColor: AppColors.darkBlue,
                    focusNode: focusNode,
                    cursorHeight: R.sH(context, 30),
                    cursorWidth: R.sW(context, 3),
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    style: TextStyle(
                      fontSize: R.sH(context, 16),
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'message'.tr(),
                      hintStyle: TextStyle(
                        color: AppColors.grey2,
                        fontSize: R.F(context, 20),
                        fontWeight: FontWeightManager.regular,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                 Navigator.pushNamed(context, Routes.cameraRoute ,arguments: {
                      'uId': receiverId,
                    });
                  },
                child: const Icon(
                  Icons.image_outlined,
                  color: Colors.grey,
                  size: 26,
                ),
              ),
              /*   if (messageController.text.isEmpty)
                IconButton(
                  onPressed: () {
                    navigateTo(context, Routes.cameraRoute, arguments: {
                      'id': receiverId,
                    });
                  },
                  color: Colors.grey,
                  iconSize: 26,
                  icon: const Icon(Icons.camera_alt_rounded),
                ),*/
            ],
          ),
        ],
      ),
    );
  }
}
