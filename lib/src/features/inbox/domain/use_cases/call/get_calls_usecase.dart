import 'package:schmitt/src/core/usecase/base_use_case.dart';
import 'package:schmitt/src/features/inbox/domain/entities/call.dart';
import 'package:schmitt/src/features/inbox/domain/repositories/base_call_repository.dart';

class GetCallsUseCase extends StreamBaseUseCase<List<Call>,Map<String,dynamic> >{
  final BaseCallRepository _baseChatRepository;

  GetCallsUseCase(this._baseChatRepository);
  @override
  Stream<List<Call>> call(Map<String,dynamic>  parameters) {
    return _baseChatRepository.getCalls(parameters);
  }
}