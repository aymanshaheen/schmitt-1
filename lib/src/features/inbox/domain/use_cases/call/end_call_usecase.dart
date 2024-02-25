import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/error/error_handler.dart';
import 'package:schmitt/src/core/usecase/base_use_case.dart';
import 'package:schmitt/src/features/inbox/domain/repositories/base_call_repository.dart';


class EndCallUseCase extends BaseUseCase<void, EndCallParameters> {
  final BaseCallRepository _baseCallRepository;

  EndCallUseCase(this._baseCallRepository);

  @override
  Future<Either<Failure, void>> call(EndCallParameters parameters) async {
    return await _baseCallRepository.endCall(parameters);
  }
}

class EndCallParameters extends Equatable {
  final String callerId;
  final String receiverId;

  const EndCallParameters({
    required this.callerId,
    required this.receiverId,
  });

  @override
  List<Object?> get props => [
        callerId,
        receiverId,
      ];
}
