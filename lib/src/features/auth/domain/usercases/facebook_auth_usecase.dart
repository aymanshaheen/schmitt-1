import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/auth/domain/repository/user_repository.dart';

class FacebookAuthUseCase {
  final UserRepository repository;

  FacebookAuthUseCase( this.repository);

 ResultVoid call() {
    return repository.facebookAuth();
  }
}
