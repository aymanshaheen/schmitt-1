import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/auth/domain/repository/user_repository.dart';

class GoogleAuthUseCase {
  final UserRepository repository;

  GoogleAuthUseCase({required this.repository});

 ResultVoid call() {
    return repository.googleAuth();
  }
}
