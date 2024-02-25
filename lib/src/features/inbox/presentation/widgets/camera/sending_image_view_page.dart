import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/functions/commen.dart';
import 'package:schmitt/src/core/utils/enum.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'components/image_view_top_row_icons.dart';
import 'components/sending_image_video_bottom_roww_widget.dart';

class SendingImageViewPage extends StatefulWidget {
  String path;
  final String receiverId;

   SendingImageViewPage({
    super.key,
    required this.path,
    required this.receiverId,
  });

  @override
  State<SendingImageViewPage> createState() => _SendingImageViewPageState();
}

class _SendingImageViewPageState extends State<SendingImageViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Image.file(
              File(widget.path),
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
            ImageViewTopRowIcons(
              onCropButtonTaped: () {
                cropImage(widget.path).then((value) {
                  widget.path = value!.path;
                  setState(() {

                  });
                });
              },
            ),
            BlocBuilder<ChatCubit,ChatState>(
              builder: (context,state) {
                return Positioned(
                  bottom: 5,
                  right: 0,
                  left: 0,
                  child: SendingImageVideoBottomRowWidget(
                    onSendButtonTaped: () {
                      ChatCubit.get(context).sendFileMessage(
                        receiverId: widget.receiverId,
                        messageType: MessageType.image,
                        file: File(widget.path),
                      );
                      //to back to chat screen
                      int count = 0;
                      Navigator.of(context).popUntil((route) => count++ >= 2);
                    },
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
