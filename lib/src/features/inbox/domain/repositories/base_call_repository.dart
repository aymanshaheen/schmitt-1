import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:schmitt/src/core/error/error_handler.dart';
import 'package:schmitt/src/features/inbox/domain/entities/call.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/call/end_call_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/call/make_call_usecase.dart';

abstract class BaseCallRepository{
Future<Either<Failure,Call>> makeCall(MakeCallParameters parameters);
Future<Either<Failure,void>> endCall(EndCallParameters parameters);
Stream<DocumentSnapshot> callStream(String callId);
Stream<List<Call>> getCalls(Map<String,dynamic> map);
}