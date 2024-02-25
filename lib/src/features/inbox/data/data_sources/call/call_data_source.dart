import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/features/auth/data/model/user_model_save.dart';
import 'package:schmitt/src/features/inbox/data/models/call_model.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/call/end_call_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/call/make_call_usecase.dart';
import 'package:uuid/uuid.dart';

abstract class BaseCallDataSource {
  Future<CallModel> makeCall(MakeCallParameters parameters);
  Future<void> endCall(EndCallParameters parameters);
  Stream<DocumentSnapshot> callStream(String callId);
  Stream<List<CallModel>> getCalls(Map<String, dynamic> map);
}

class CallDataSource extends BaseCallDataSource {
  final FirebaseFirestore firestore;

  CallDataSource({required this.firestore});

  Future<UserModelSave> _currentUser() async {
    var userDataMap =
    await firestore.collection('users').doc(AppConstants.id.toString()).get();
    UserModelSave user = UserModelSave.fromMap(userDataMap.data()!);
    return user;
  }

@override
Stream<DocumentSnapshot> callStream(String callId) =>
    firestore.collection('users').doc(AppConstants.id.toString()).collection('calls').doc(callId).snapshots();
@override
Future<void> endCall(EndCallParameters parameters) async {
  await firestore.collection('users').doc(parameters.callerId).collection('calls').doc(parameters.callerId).delete();
  await firestore.collection('users').doc(parameters.receiverId).collection('calls').doc(parameters.receiverId).delete();
}

@override
Future<CallModel> makeCall(MakeCallParameters parameters) async {
  String callId = const Uuid().v1();
  UserModelSave currentUser = await _currentUser();
  CallModel senderCallData = CallModel(
    callerId: currentUser.id.toString(),
    callerName: currentUser.name!,
    callerPic: currentUser.avatar!,
    receiverId: parameters.receiverId,
    receiverName: parameters.receiverName,
    receiverPic: parameters.receiverPic,
    callId: callId,
    hasDialled: true,
  );

  CallModel receiverCallData = CallModel(
    callerId: currentUser.id.toString(),
    callerName: currentUser.name!,
    callerPic: currentUser.avatar!,
    receiverId: parameters.receiverId,
    receiverName: parameters.receiverName,
    receiverPic: parameters.receiverPic,
    callId: callId,
    hasDialled: false,
  );

  await firestore
      .collection('users')
      .doc(senderCallData.callerId)
      .collection('calls')
      .doc(callId)
      .set(senderCallData.toMap());
  await firestore
      .collection('users')
      .doc(senderCallData.receiverId)
      .collection('calls')
      .doc(callId)
      .set(receiverCallData.toMap());
  return senderCallData;
}


  @override
  Stream<List<CallModel>> getCalls(Map<String, dynamic> map) {
    return firestore
        .collection('users')
        .doc(AppConstants.id.toString())
        .collection('calls')
        //.orderBy('timeSent', descending: true)
        .snapshots()
        .asyncMap((event) async {
      List<CallModel> contacts = [];
      for (var document in event.docs) {
        CallModel contactChat =
            CallModel.fromMap(document.data());
        var userData = await firestore
            .collection('users')
            .doc(contactChat.callerId)
            .get();
        var user = CallModel.fromMap(userData.data()!);
        contacts.add(
          CallModel(
            callerId: user.callerId,
            callerName: user.callerName,
            callerPic: user.callerPic,
            receiverId: contactChat.receiverId,
            receiverName: contactChat.receiverName,
            receiverPic: contactChat.receiverPic,
            callId: contactChat.callId,
            hasDialled: contactChat.hasDialled,
          ),
        );
      }
      return contacts;
    });
  }
}
