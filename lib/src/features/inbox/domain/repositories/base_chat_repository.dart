import 'package:dartz/dartz.dart';
import 'package:schmitt/src/core/error/error_handler.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/get_chat_messages_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/send_file_message_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/send_text_message_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/set_chat_message_seen_usecase.dart';
import '../entities/contact_chat.dart';
import '../entities/message.dart';

abstract class BaseChatRepository {
  Future<Either<Failure, void>> sendTextMessage(
      TextMessageParameters parameters);
  Stream<List<ContactChat>> getContactsChat(Map<String, dynamic> map);
  Stream<List<Message>> getChatMessages(GetChatMessagesParameters parameters);
  Future<Either<Failure, void>> setChatMessageSeen(
      SetChatMessageSeenParameters parameters);
  Stream<int> getNumOfMessageNotSeen(String senderId);
  Future<Either<Failure, void>> sendFileMessage(
      FileMessageParameters parameters);
}
