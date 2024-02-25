import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/enum.dart';
import 'package:schmitt/src/features/inbox/domain/entities/message.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/message_content/text_widget.dart';
import 'audio_player_widget.dart';
import 'image_widget.dart';

class MessageContent extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageContent({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    switch (message.messageType) {
      case MessageType.text:
        return TextWidget(message: message, isMe: isMe);
      case MessageType.image:
        return ImageWidget(message: message, isMe: isMe);
    /*  case MessageType.video:
        return VideoPlayerItem(message: message, isMe: isMe);*/
      case MessageType.audio:
        return AudioPlayerWidget(message: message, isMe: isMe);
      default:
        return TextWidget(message: message, isMe: isMe);
    }
  }
}