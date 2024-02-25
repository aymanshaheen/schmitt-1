import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schmitt/src/core/usecase/base_use_case.dart';
import 'package:schmitt/src/features/inbox/domain/repositories/base_call_repository.dart';

class CallStreamUseCase extends StreamBaseUseCase<DocumentSnapshot,String>{
  final BaseCallRepository _baseCallRepository;

  CallStreamUseCase(this._baseCallRepository);
  @override
  Stream<DocumentSnapshot> call(String parameters) {
    return _baseCallRepository.callStream(parameters);
  }
}