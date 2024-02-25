import 'package:schmitt/src/core/usecase/base_use_case.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/auth/data/model/user_model_save.dart';
import 'package:schmitt/src/features/auth/domain/repository/user_repository.dart';

class GetCurrentUserUseCase extends BaseUseCase<UserModelSave, NoParameters> {
  final UserRepository repository;

  GetCurrentUserUseCase(this.repository);
  @override
  ResultFuture<UserModelSave> call(NoParameters parameters) async {
    return await repository.getCurrentUser();
  }
}
