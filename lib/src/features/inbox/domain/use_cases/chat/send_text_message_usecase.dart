import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/error/error_handler.dart';
import 'package:schmitt/src/core/usecase/base_use_case.dart';
import 'package:schmitt/src/features/inbox/domain/entities/message_replay.dart';
import 'package:schmitt/src/features/inbox/domain/repositories/base_chat_repository.dart';


class SendTextMessageUseCase extends BaseUseCase<void, TextMessageParameters> {
  final BaseChatRepository _baseChatRepository;

  SendTextMessageUseCase(this._baseChatRepository);

  @override
  Future<Either<Failure, void>> call(TextMessageParameters parameters) async {
    return await _baseChatRepository.sendTextMessage(parameters);
  }
}

class TextMessageParameters extends Equatable {
  final String text;
  final String receiverId;
  final MessageReplay? messageReplay;


  const TextMessageParameters({
    required this.receiverId,
    required this.text,
    this.messageReplay,
  });

  @override
  List<Object?> get props => [
        text,
        receiverId,
        messageReplay,
      ];
}
