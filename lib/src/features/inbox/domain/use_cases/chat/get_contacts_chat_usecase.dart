import 'package:schmitt/src/core/usecase/base_use_case.dart';
import 'package:schmitt/src/features/inbox/domain/repositories/base_chat_repository.dart';

import '../../entities/contact_chat.dart';


class GetContactsChatUseCase extends StreamBaseUseCase<List<ContactChat>,Map<String,dynamic> >{
  final BaseChatRepository _baseChatRepository;

  GetContactsChatUseCase(this._baseChatRepository);
  @override
  Stream<List<ContactChat>> call(Map<String,dynamic>  parameters) {
    return _baseChatRepository.getContactsChat(parameters);
  }
}