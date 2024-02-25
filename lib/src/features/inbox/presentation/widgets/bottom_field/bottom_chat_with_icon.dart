import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/bottom_chat_cubit/bottom_chat_cubit.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'bottom_chat_field.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/bottom_field/recording_mic.dart';

class BottomChatWithIcon extends StatefulWidget {
  final String receiverId;

  const BottomChatWithIcon({
    super.key,
    required this.receiverId,
  });

  @override
  State<BottomChatWithIcon> createState() => _BottomChatWithIconState();
}

class _BottomChatWithIconState extends State<BottomChatWithIcon> {
  final TextEditingController messageController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomChatCubit, BottomChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        BottomChatCubit cubit = BottomChatCubit.get(context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(R.sW(context, 4)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BottomChatField(
                    receiverId: widget.receiverId,
                    focusNode: focusNode,
                    messageController: messageController,
                    onTextFieldValueChanged: (val) =>
                        cubit.onTextFieldValChanged(val),
                  ),
                  if (cubit.isShownSendButton == false)
                  BlocBuilder<BottomChatCubit, BottomChatState>(
                    builder: (context, state) {
                      if (BottomChatCubit.get(context).isShownSendButton ==
                          false) {
                        return RecordingMic(receiverId: widget.receiverId);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  if (cubit.isShownSendButton)
                    BlocBuilder<ChatCubit, ChatState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            ChatCubit.get(context).sendTextMessage(
                              text: messageController.text.trim(),
                              receiverId: widget.receiverId,
                            );
                            messageController.clear();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.00),
                              color: AppColors.darkBlue,
                            ),
                            width: R.sW(context, 50),
                            height: R.sH(context, 50),
                            child: Center(
                              child: Icon(
                                Icons.send,
                                size: R.sW(context, 25),
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }
}
