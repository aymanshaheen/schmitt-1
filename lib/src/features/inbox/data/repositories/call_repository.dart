import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:schmitt/src/core/error/error_handler.dart';
import 'package:schmitt/src/features/inbox/data/data_sources/call/call_data_source.dart';
import 'package:schmitt/src/features/inbox/domain/entities/call.dart';
import 'package:schmitt/src/features/inbox/domain/repositories/base_call_repository.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/call/end_call_usecase.dart';
import 'package:schmitt/src/features/inbox/domain/use_cases/call/make_call_usecase.dart';


class CallRepository extends BaseCallRepository{
  final CallDataSource _callDataSource;

  CallRepository(this._callDataSource);

  @override
  Stream<DocumentSnapshot<Object?>> callStream(String callId) => _callDataSource.callStream( callId);

  @override
  Future<Either<Failure, void>> endCall(EndCallParameters parameters) async{
    final result = await _callDataSource.endCall(parameters);
    try{
      return Right(result);
    }on FirebaseException catch(failure){
      return Left(ErrorHandler.handle(failure.message!).failure);
    }
  }
  @override
  Stream<List<Call>> getCalls(Map<String,dynamic> map) {
    return  _callDataSource.getCalls(map);
  }
  @override
  Future<Either<Failure, Call>> makeCall(MakeCallParameters parameters)async {
    final result = await _callDataSource.makeCall(parameters);
    try{
      return Right(result);
    }on FirebaseException catch(failure){
      return Left(ErrorHandler.handle(failure.message!).failure);
    }
  }
}