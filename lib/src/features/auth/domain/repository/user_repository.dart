import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/auth/data/model/user_model_save.dart';
import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_in_usecase.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_up_usecase.dart';

abstract class UserRepository {
  ResultFuture<UserEntity> signIn(SignInParams params);
  ResultFuture<UserEntity> signUp(SignUpParams params);
 // ResultVoid saveUserDataToFirebase(UserEntity user);
  ResultVoid googleAuth();
  ResultVoid facebookAuth();
  ResultFuture<UserModelSave> getCurrentUser();

  /* ResultVoid forgotPassword(String email);
  */
}
