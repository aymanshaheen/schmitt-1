import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/error/error_handler.dart';
import 'package:schmitt/src/core/usecase/base_use_case.dart';
import 'package:schmitt/src/features/inbox/domain/entities/call.dart';
import 'package:schmitt/src/features/inbox/domain/repositories/base_call_repository.dart';

class MakeCallUseCase extends BaseUseCase<Call, MakeCallParameters> {
  final BaseCallRepository _baseCallRepository;

  MakeCallUseCase(this._baseCallRepository);

  @override
  Future<Either<Failure, Call>> call(MakeCallParameters parameters) async {
    return await _baseCallRepository.makeCall(parameters);
  }
}

class MakeCallParameters extends Equatable {
  final String receiverId;
  final String receiverName;
  final String receiverPic;

  const MakeCallParameters({
    required this.receiverId,
    required this.receiverName,
    required this.receiverPic,
  });

  @override
  List<Object?> get props => [
        receiverId,
        receiverName,
        receiverPic,
      ];
}
