import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';
import 'package:schmitt/src/features/home/domain/repositories/home_repository.dart';

class ShowProfileUseCase {

  ShowProfileUseCase({required this.repository});
  final HomeRepository repository;

  ResultFuture<UserEntity> call() {
    return repository.showProfile();
  }
}

