import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';
import 'package:schmitt/src/features/auth/domain/repository/user_repository.dart';

class SignUpUseCase {
  final UserRepository repository;

  SignUpUseCase({required this.repository});

  ResultFuture<UserEntity> call(SignUpParams params) {
    return repository.signUp(params);
  }
}

class SignUpParams extends Equatable {
  final String name;
  final String email;
  final String? password;
  final String? passwordConfirm;
  final String? phone;
  final String? phoneCode;
  final String? area;
  final String? city;
  final String type;

  const SignUpParams({
    required this.name,
     this.password,
     this.passwordConfirm,
     this.city,
    required this.email,
     this.phone,
     this.phoneCode,
     this.area,
    required this.type,
  });

  @override
  List<Object?> get props => [name, email, password, passwordConfirm, phone, phoneCode, area, city, type];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirm,
      'phone': phone,
      'phone_code': phoneCode,
      'area': area,
      'city': city,
      'type': type,
    };
  }
}