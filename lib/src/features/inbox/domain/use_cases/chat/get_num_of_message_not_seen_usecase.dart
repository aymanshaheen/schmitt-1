
import 'package:schmitt/src/core/usecase/base_use_case.dart';
import 'package:schmitt/src/features/inbox/domain/repositories/base_chat_repository.dart';

class GetNumberOfMessageNotSeenUseCase extends StreamBaseUseCase<int,String>{
  final BaseChatRepository _baseChatRepository;

  GetNumberOfMessageNotSeenUseCase(this._baseChatRepository);
  @override
  Stream<int> call(String parameters) {
    return _baseChatRepository.getNumOfMessageNotSeen(parameters);
  }
}