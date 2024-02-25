import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/utils/enum.dart';

class MessageReplay extends Equatable {
  final String message;
  final bool isMe;
  final MessageType messageType;
  final String repliedTo;

  const MessageReplay({
    required this.message,
    required this.isMe,
    required this.messageType,
    required this.repliedTo,
  });

  @override
  List<Object?> get props => [
        message,
        isMe,
        messageType,
        repliedTo,
      ];
}
