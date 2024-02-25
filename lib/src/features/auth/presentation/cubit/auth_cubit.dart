
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/usecase/base_use_case.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';
import 'package:schmitt/src/features/auth/domain/usercases/facebook_auth_usecase.dart';
import 'package:schmitt/src/features/auth/domain/usercases/forgot_password_usecase.dart';
import 'package:schmitt/src/features/auth/domain/usercases/get_current_user_usecase.dart';
import 'package:schmitt/src/features/auth/domain/usercases/google_auth_usecase.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_in_usecase.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_up_usecase.dart';
part 'auth_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final FacebookAuthUseCase facebookAuthUseCase;
  final GoogleAuthUseCase googleAuthUseCase;

  CredentialCubit(
      {required this.signUpUseCase,
      required this.getCurrentUserUseCase,
      required this.facebookAuthUseCase,
      required this.signInUseCase,
      required this.forgotPasswordUseCase,
      required this.googleAuthUseCase})
      : super(CredentialInitial());
  static CredentialCubit get(context) => BlocProvider.of(context);

  /*Future<void> forgotPassword({required String email}) async {
   
      final result = await forgotPasswordUseCase.call(email);
      result.fold(
        (failure) => emit(CredentialFailure(
            message: failure.message,)),
        (_) => {},
      );
 
  }*/

  Future<void> googleAuthSubmit() async {
    emit(CredentialLoading());
    try {
      final result = await googleAuthUseCase.call();
      result.fold(
        (failure) => emit(CredentialFailure(
          message: failure.message,
        )),
        (right) {
          emit(const CredentialGoogleSuccess());
        },
      );
    } catch (e) {
      emit(CredentialFailure(message: e.toString()));
    }
  }
  Future<void> facebookAuthSubmit() async {
    emit(CredentialLoading());
    try {
      final result = await facebookAuthUseCase.call();
      result.fold(
        (failure) => emit(CredentialFailure(
          message: failure.message,
        )),
        (right) {
          emit(const CredentialGoogleSuccess());
        },
      );
    } catch (e) {
      emit(CredentialFailure(message: e.toString()));
    }
  }

  Future<void> getCurrentUser() async {
    emit(GetCurrentUserLoadingState());
    final result = await getCurrentUserUseCase(const NoParameters());
    result.fold(
      (l) => emit(GetCurrentUserErrorState()),
      (r) {
        AppConstants.currentUser = r;
        emit(GetCurrentUserSuccessState());
      },
    );
  }

 /* Future<void> saveUserDataToFirebase({
    UserEntity? user,
  }) async {
    emit(SaveUserDataToFirebaseLoadingState());
    final result = await saveUserDataToFirebaseUseCase(user!);
    result.fold(
      (l) => emit(SaveUserDataToFirebaseErrorState()),
      (r) => emit(SaveUserDataToFirebaseSuccessState()),
    );
  }
*/
  Future<void> signInSubmit(SignInParams params) async {
    emit(CredentialLoading());

    final result = await signInUseCase.call(params);
    result.fold(
      (failure) => emit(CredentialFailure(
        message: failure.message,
      )),
      (right) => emit(CredentialSuccess(right)),
    );
  }


  Future<void> signUpSubmit(SignUpParams signUpParams) async {
    emit(CredentialLoading());

    final result = await signUpUseCase.call(signUpParams);

    result.fold(
      (failure) {
        emit(CredentialFailure(
          message: failure.message,
        ));
      },
      (user) => emit(CredentialSuccess(user)),
    );
  }
}
