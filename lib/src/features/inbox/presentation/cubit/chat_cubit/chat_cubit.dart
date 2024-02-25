import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/enum.dart';
import 'package:schmitt/src/features/inbox/domain/entities/message_replay.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/get_chat_messages_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/get_contacts_chat_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/get_num_of_message_not_seen_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/send_file_message_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/send_text_message_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/set_chat_message_seen_usecase.dart';
import '../../../domain/entities/contact_chat.dart';
import '../../../domain/entities/message.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendTextMessageUseCase sendTextMessageUseCase;
  final GetContactsChatUseCase getContactsChatUseCase;
  final GetChatMessagesUseCase getChatMessagesUseCase;
  final SetChatMessageSeenUseCase setChatMessageSeenUseCase;
  final GetNumberOfMessageNotSeenUseCase getNumberOfMessageNotSeenUseCase;
  final SendFileMessageUseCase sendFileMessageUseCase;

  ChatCubit({
    required this.sendFileMessageUseCase,
    required this.sendTextMessageUseCase,
    required this.getContactsChatUseCase,
    required this.getChatMessagesUseCase,
    required this.setChatMessageSeenUseCase,
    required this.getNumberOfMessageNotSeenUseCase,
  }) : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  MessageReplay? messageReplay;

  void onMessageSwipe({
    required String message,
    required bool isMe,
    required MessageType messageType,
    required String repliedTo,
  }) {
    emit(MessageSwipeLoadingState());
    messageReplay = MessageReplay(
      message: message,
      isMe: isMe,
      messageType: messageType,
      repliedTo: repliedTo,
    );
    emit(MessageSwipeState());
  }

  void cancelReplay() {
    messageReplay = null;
    emit(CancelReplayState());
  }

  ///sending messages
  Future<void> sendTextMessage({
    required String text,
    required String receiverId,
  }) async {
    emit(SendMessageLoadingState());
    final result = await sendTextMessageUseCase(
      TextMessageParameters(
        text: text,
        receiverId: receiverId,
        messageReplay: messageReplay,
      ),
    );
    messageReplay = null;
    result.fold(
      (l) => emit(SendMessageErrorState()),
      (r) => emit(SendMessageSuccessState()),
    );
  }

  Future<void> sendFileMessage({
    required String receiverId,
    required MessageType messageType,
    required File file,
  }) async {
    final result = await sendFileMessageUseCase(
      FileMessageParameters(
        receiverId: receiverId,
        messageType: messageType,
        file: file,
        messageReplay: messageReplay,
      ),
    );
    messageReplay = null;
    result.fold(
      (l) => emit(SendMessageErrorState()),
      (r) => emit(SendMessageSuccessState()),
    );
  }

  ///get messages
  Stream<List<ContactChat>> getContactsChat(Map<String, dynamic> map) {
    return getContactsChatUseCase(map);
  }

  Stream<List<Message>> getChatMessages(String receiverId) {
    return getChatMessagesUseCase(
      GetChatMessagesParameters(
        receiverId: receiverId,
      ),
    );
  }

  ///set message seen
  Future<void> setChatMessageSeen({
    required String receiverId,
    required String messageId,
  }) async {
    final result = await setChatMessageSeenUseCase(
      SetChatMessageSeenParameters(
        receiverId: receiverId,
        messageId: messageId,
      ),
    );
    result.fold(
      (l) => null,
      (r) => null,
    );
  }

  ///get num of messages not seen
  Stream<int> numOfMessageNotSeen(String senderId) =>
      getNumberOfMessageNotSeenUseCase(senderId);
}
