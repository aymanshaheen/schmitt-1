import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/utils/enum.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/bottom_chat_cubit/bottom_chat_cubit.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';

class RecordingMic extends StatefulWidget {
  final String receiverId;
  const RecordingMic({
    super.key,
    required this.receiverId,
  });

  @override
  State<RecordingMic> createState() => _RecordingMicState();
}

class _RecordingMicState extends State<RecordingMic> {
  final recorderController = RecorderController();
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomChatCubit>(
      create: (context) => sl<BottomChatCubit>(),
      child: BlocBuilder<BottomChatCubit, BottomChatState>(
        builder: (context, state) {
          BottomChatCubit cubit = BottomChatCubit.get(context);
          return Visibility(
            visible: !cubit.isShownSendButton,
            child: GestureDetector(
              onTap: () {
                if (isRecording) {
                  stopRecording(context);
                } else {
                  startRecording();
                }
                setState(() {
                  isRecording = !isRecording;
                });
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
                    Icons.mic_rounded,
                    size: R.sW(context, 25),
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void startRecording() async {
    if (await recorderController.checkPermission()) {
      await recorderController.record();
    }
  }

  void cancelRecord() async {
    await recorderController.stop();
  }

 void stopRecording(context) async {
  final path = await recorderController.stop();
  final file = File(path!);
  if (await file.exists()) {
    ChatCubit.get(context).sendFileMessage(
      receiverId: widget.receiverId,
      messageType: MessageType.audio,
      file: file,
    );
  }
}

  @override
  void dispose() {
    super.dispose();
    recorderController.dispose();
  }
}
