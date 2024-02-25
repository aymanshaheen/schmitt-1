import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:schmitt/src/core/error/error_handler.dart';
import 'package:schmitt/src/features/inbox/data/data_sources/chat/remote/chat_remote_data_source.dart';
import 'package:schmitt/src/features/inbox/domain/repositories/base_chat_repository.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/get_chat_messages_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/send_file_message_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/send_text_message_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/set_chat_message_seen_usecase.dart';
import '../../domain/entities/contact_chat.dart';
import '../../domain/entities/message.dart';


class ChatRepository extends BaseChatRepository {
  final BaseChatRemoteDataSource _remoteDataSource;

  ChatRepository(this._remoteDataSource);

  @override
  Stream<List<Message>> getChatMessages(GetChatMessagesParameters parameters) {
   return _remoteDataSource.getChatMessages(parameters);
  }

  @override
  Stream<List<ContactChat>> getContactsChat(Map<String,dynamic> map) {
    return  _remoteDataSource.getContactsChat(map);
  }

 @override
  Future<Either<Failure, void>> sendFileMessage(FileMessageParameters parameters)async {
    final result = await _remoteDataSource.sendFileMessage(parameters);
    try{
      return Right(result);
    }on FirebaseException catch(failure){
      return Left(ErrorHandler.handle(failure.message!).failure);
    }
  }
  @override
  Future<Either<Failure, void>> sendTextMessage(TextMessageParameters parameters) async {
    final result = await _remoteDataSource.sendTextMessage(parameters);
    try{
      return Right(result);
    }on FirebaseException catch(failure){
      return Left(ErrorHandler.handle(failure.message!).failure);
    }
  }

  @override
  Future<Either<Failure, void>> setChatMessageSeen(SetChatMessageSeenParameters parameters)async {
    final result = await _remoteDataSource.setChatMessageSeen(parameters);
    try{
      return Right(result);
    }on FirebaseException catch(failure){
      return Left(ErrorHandler.handle(failure.message!).failure);
    }
  }


  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    return _remoteDataSource.getNumOfMessageNotSeen(senderId);
  }
}
