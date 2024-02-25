import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';
import 'package:schmitt/src/features/auth/domain/repository/user_repository.dart';

class SignInUseCase {

  SignInUseCase({required this.repository});
  final UserRepository repository;

  ResultFuture<UserEntity> call(SignInParams params) {
    return repository.signIn(params);
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;


  const SignInParams({
    required this.password,

    required this.email,

  });
   Map<String, dynamic> toJson() {
    return {
      'password': password,
      'username': email,
    };
  }

  @override
  List<Object?> get props => [ email,password];
}
