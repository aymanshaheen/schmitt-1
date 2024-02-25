
import 'package:schmitt/src/features/auth/domain/repository/user_repository.dart';

class ForgotPasswordUseCase{
  final UserRepository repository;

  ForgotPasswordUseCase({required this.repository});
/*
  ResultVoid call(String email){
    return repository.forgotPassword(email);
  }*/
}