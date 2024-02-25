import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/enum.dart';
import 'package:schmitt/src/features/auth/data/model/user_model_save.dart';
import 'package:schmitt/src/features/inbox/domain/entities/message_replay.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/get_chat_messages_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/send_file_message_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/send_text_message_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/chat/set_chat_message_seen_usecase.dart';
import 'package:uuid/uuid.dart';
import '../../../models/contact_chat_model.dart';
import '../../../models/message_model.dart';

abstract class BaseChatRemoteDataSource {
  Future<void> sendTextMessage(TextMessageParameters parameters);

  Stream<List<MessageModel>> getChatMessages(
      GetChatMessagesParameters parameters);
  Future<void> sendFileMessage(FileMessageParameters parameters);

  Stream<List<ContactChatModel>> getContactsChat(Map<String, dynamic> map);

  Future<void> setChatMessageSeen(SetChatMessageSeenParameters parameters);
  Stream<int> getNumOfMessageNotSeen(String senderId);
}

class ChatRemoteDataSource extends BaseChatRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;
  final DioHelper dio;
  final FirebaseAuth auth;

  ChatRemoteDataSource( 
      {required this.firestore,
      required this.auth,required this.dio,
      required this.firebaseStorage});

  Future<UserModelSave> _currentUser() async {
    var userDataMap =
        await firestore.collection('users').doc(AppConstants.id.toString()).get();
    UserModelSave user = UserModelSave.fromMap(userDataMap.data()!);
    return user;
  }

  @override
  Future<void> sendTextMessage(TextMessageParameters parameters) async {
    UserModelSave receiverUserData;
    var timeSent = DateTime.now();
    var messageId = const Uuid().v1();
    var userDataMap =
        await firestore.collection('users').doc(parameters.receiverId).get();
    receiverUserData = UserModelSave.fromMap(userDataMap.data()!);
    UserModelSave senderUser = await _currentUser();

    _saveDataToContactsSubCollection(
      senderUser,
      receiverUserData,
      parameters.text,
      timeSent,
    );
    _saveMessageToMessageSubCollection(
      senderId: senderUser.id.toString(),
      receiverId: parameters.receiverId,
      text: parameters.text,
      timeSent: timeSent,
      messageId: messageId,
      messageType: MessageType.text,
      messageReplay: parameters.messageReplay,
      senderUserName: senderUser.name!,
    );
    sendMessageNotification(senderUser.name!,parameters.text,receiverUserData.deviceToken!);
  }
void sendMessageNotification(String name,String message,String deviceToken) async {
    try {
      var body={
        "to":deviceToken,
        "notification": {
          "title": name,
          "body": message,
        },
      };
       await dio.postNotificationData(data:body,);
    } on DioException catch (error) {
      debugPrint('DioException occurred: ${error.message}');
      if (error.response != null) {
        debugPrint('HTTP status code: ${error.response?.statusCode}');
        debugPrint('Response data: ${error.response?.data}');
      } else {
        debugPrint('Response is null');
      }
      debugPrint('Request info: ${error.requestOptions}');
      rethrow;
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }
  void _saveDataToContactsSubCollection(
    UserModelSave senderUserData,
    UserModelSave receiverUserData,
    String text,
    DateTime timeSent,
  ) async {
    // users -> receiver user id => chats -> current user id -> set data
    ContactChatModel receiverChatContact = ContactChatModel(
      name: senderUserData.name!,
      profilePic: senderUserData.avatar!,
      contactId: senderUserData.id.toString(),
      lastMessage: text,
      timeSent: timeSent,
      phoneNumber: senderUserData.phone!,
    );
    await firestore
        .collection('users')
        .doc(receiverUserData.id.toString())
        .collection('chats')
        .doc(senderUserData.id.toString())
        .set(receiverChatContact.toMAp());

    // users -> current user id => chats -> receiver user id -> set data
    ContactChatModel senderChatContact = ContactChatModel(
      name: receiverUserData.name!,
      profilePic: receiverUserData.avatar!,
      contactId: receiverUserData.id.toString(),
      lastMessage: text,
      timeSent: timeSent,
      phoneNumber: receiverUserData.phone!,
    );
    await firestore
        .collection('users')
        .doc(senderUserData.id.toString())
        .collection('chats')
        .doc(receiverUserData.id.toString())
        .set(senderChatContact.toMAp());
  }

  void _saveMessageToMessageSubCollection({
    required String senderId,
    required String receiverId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required MessageType messageType,
    required MessageReplay? messageReplay,
    required String senderUserName,
  }) async {
    MessageModel message = MessageModel(
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      messageId: messageId,
      timeSent: timeSent,
      isSeen: false,
      messageType: messageType,
      repliedMessage: messageReplay == null ? '' : messageReplay.message,
      senderName: senderUserName,
      repliedTo: messageReplay == null
          ? ''
          : messageReplay.isMe
              ? senderUserName
              : messageReplay.repliedTo,
      repliedMessageType:
          messageReplay == null ? MessageType.text : messageReplay.messageType,
    );
    // users -> sender id -> chats -> receiver id -> messages ->message id ->store message
    await firestore
        .collection('users')
        .doc(senderId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());

    // users -> receiver id -> chats -> sender id -> messages ->message id ->store message
    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(senderId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
  }

  @override
  Future<void> sendFileMessage(FileMessageParameters parameters) async {
    DateTime timeSent = DateTime.now();
    String messageId = const Uuid().v1();
    UserModelSave senderUser = await _currentUser();
    var fileUrl = await _storeFileToFirebase(
      'chat/${parameters.messageType.type}/${senderUser.id}/${parameters.receiverId}/$messageId}',
      parameters.file,
    );
    UserModelSave receiverUserData;

    var userDataMap =
        await firestore.collection('users').doc(parameters.receiverId).get();
    receiverUserData = UserModelSave.fromMap(userDataMap.data()!);

    String contactMessage;
    switch (parameters.messageType) {
      case MessageType.image:
        contactMessage = '📷 Photo';
        break;
      case MessageType.video:
        contactMessage = '🎥 Video';
        break;
      case MessageType.audio:
        contactMessage = '🎙️ Audio';
        break;
      default:
        contactMessage = 'Other';
    }

    _saveDataToContactsSubCollection(
      senderUser,
      receiverUserData,
      contactMessage,
      timeSent,
    );
    _saveMessageToMessageSubCollection(
        senderId: senderUser.id.toString(),
        receiverId: parameters.receiverId,
        text: fileUrl,
        timeSent: timeSent,
        messageId: messageId,
        messageType: parameters.messageType,
        messageReplay: parameters.messageReplay,
        senderUserName: senderUser.name!);
  }

  Future<String> _storeFileToFirebase(String path, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(path).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Stream<List<MessageModel>> getChatMessages(
      GetChatMessagesParameters parameters) {
    return firestore
        .collection('users')
        .doc(AppConstants.id.toString())
        .collection('chats')
        .doc(parameters.receiverId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<MessageModel> messages = [];
      for (var document in event.docs) {
        messages.add(MessageModel.fromMap(document.data()));
      }
      return messages;
    });
  }

  @override
  Stream<List<ContactChatModel>> getContactsChat(Map<String, dynamic> map) {
    return firestore
        .collection('users')
        .doc(AppConstants.id.toString())
        .collection('chats')
        .orderBy('timeSent', descending: true)
        .snapshots()
        .asyncMap((event) async {
      List<ContactChatModel> contacts = [];
      for (var document in event.docs) {
        ContactChatModel contactChat =
            ContactChatModel.fromMap(document.data());
        var userData = await firestore
            .collection('users')
            .doc(contactChat.contactId)
            .get();
        var user = UserModelSave.fromMap(userData.data()!);
        contacts.add(
          ContactChatModel(
            name: map.containsKey(contactChat.contactId)
                ? map[contactChat.contactId]['name']
                : user.name,
            profilePic: user.avatar!,
            contactId: user.id.toString(),
            lastMessage: contactChat.lastMessage,
            timeSent: contactChat.timeSent,
            phoneNumber: contactChat.phoneNumber,
          ),
        );
      }
      return contacts;
    });
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    return firestore
        .collection('users')
        .doc(AppConstants.id.toString())
        .collection('chats')
        .doc(senderId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      int num = 0;
      for (var document in event.docs) {
        MessageModel message = MessageModel.fromMap(document.data());
        if (message.senderId == senderId) {
          if (!message.isSeen) {
            num++;
          }
        }
      }
      return num;
    });
  }

  @override
  Future<void> setChatMessageSeen(
      SetChatMessageSeenParameters parameters) async {
    await firestore
        .collection('users')
        .doc(AppConstants.id.toString())
        .collection('chats')
        .doc(parameters.receiverId)
        .collection('messages')
        .doc(parameters.messageId)
        .update({
      'isSeen': true,
    });
    // users -> receiver id -> chats -> sender id -> messages ->message id ->store message
    await firestore
        .collection('users')
        .doc(parameters.receiverId)
        .collection('chats')
        .doc(AppConstants.id.toString())
        .collection('messages')
        .doc(parameters.messageId)
        .update({
      'isSeen': true,
    });
  }
}
