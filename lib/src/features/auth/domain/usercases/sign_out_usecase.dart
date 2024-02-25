import 'package:schmitt/src/features/auth/domain/repository/user_repository.dart';

class SignOutUseCase {
  final UserRepository repository;

  SignOutUseCase({required this.repository});

 /* ResultFuture call() async {
    return repository.signOut();
  }*/
}
