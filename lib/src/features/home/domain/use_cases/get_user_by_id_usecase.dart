import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';
import 'package:schmitt/src/features/home/domain/repositories/home_repository.dart';
import '../../../../core/usecase/base_use_case.dart';


class GetUserByIdUseCase extends StreamBaseUseCase<UserEntity, String> {
  final HomeRepository repository;

  GetUserByIdUseCase(this.repository);

  @override
  Stream<UserEntity> call(String parameters) {
    return repository.getUserById(parameters);
  }
}
