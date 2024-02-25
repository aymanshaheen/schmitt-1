part of 'auth_cubit.dart';

abstract class CredentialState extends Equatable {
  const CredentialState();
}

class CredentialInitial extends CredentialState {
  @override
  List<Object> get props => [];
}

class CredentialLoading extends CredentialState {
  @override
  List<Object> get props => [];
}

class CredentialSuccess extends CredentialState {
  const CredentialSuccess(this.user);
  final UserEntity user;
  @override
  List<Object> get props => [user];
}

class CredentialGoogleSuccess extends CredentialState {
  const CredentialGoogleSuccess();
  @override
  List<Object> get props => [];
}

class CredentialFailure extends CredentialState {
  final String message;

  const CredentialFailure({
    required this.message,
  });
  @override
  List<Object> get props => [
        message,
      ];
}

class ForgetPasswordLoadingState extends CredentialState {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordSuccessState extends CredentialState {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordErrorState extends CredentialState {
  final String message;

  const ForgetPasswordErrorState({required this.message});

  @override
  List<Object?> get props => [];
}

class SaveUserDataToFirebaseLoadingState extends CredentialState {
  @override
  List<Object?> get props => [];
}

class SaveUserDataToFirebaseSuccessState extends CredentialState {
  @override
  List<Object?> get props => [];
}

class SaveUserDataToFirebaseErrorState extends CredentialState {
  @override
  List<Object?> get props => [];
}

class GetCurrentUserLoadingState extends CredentialState {
  @override
  List<Object?> get props => [];
}

class GetCurrentUserErrorState extends CredentialState {
  @override
  List<Object?> get props => [];
}

class GetCurrentUserSuccessState extends CredentialState {
  @override
  List<Object?> get props => [];
}

class ChangeColorMode extends CredentialState {
  @override
  List<Object?> get props => [];
}
