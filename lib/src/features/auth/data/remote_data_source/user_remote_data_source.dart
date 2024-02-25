import 'package:schmitt/src/features/auth/data/model/user_model.dart';
import 'package:schmitt/src/features/auth/data/model/user_model_save.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_in_usecase.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_up_usecase.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> signIn(SignInParams params);
  Future<UserModel> signUp(SignUpParams params);
 // Future<void> saveUserDataToFirebase(UserEntity parameters);
  Future<String> getCurrentUid();
  Future<void> googleAuth();
  Future<void> facebookAuth();
  Future<UserModelSave> getCurrentUser();

  /* Future<void> forgotPassword(String email);
  Future<void> signOut();
  */
}
