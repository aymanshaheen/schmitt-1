import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:schmitt/src/core/api/dio_helper.dart';
import 'package:schmitt/src/core/api/endpoints.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/features/auth/data/model/user_model.dart';
import 'package:schmitt/src/features/auth/data/model/user_model_save.dart';
import 'package:schmitt/src/features/auth/data/remote_data_source/user_remote_data_source.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_in_usecase.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_up_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;
  final FacebookAuth faceBookAuth;
  final FirebaseAuth auth;
  final FirebaseStorage storage;
  final DioHelper dio;

  UserRemoteDataSourceImpl({
    required this.auth,
    required this.firestore,
    required this.storage,
    required this.faceBookAuth,
    required this.googleSignIn,
    required this.dio,
  });

  /* @override
  Future<void> forgotPassword(String email) async {
    try {
     // await auth.sendPasswordResetEmail(email: email);
    } catch (error, s) {
      debugPrintStack(stackTrace: s);
      throw ErrorHandler.handle(error);
    }
  }
*/
/*
  Future<void> socialAuth(AuthCredential credential) async {
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
    final User? information = userCredential.user;
    var rng = Random();
    if (information != null) {
      // Check if a user with the same email already exists
      var users = await firestore
          .collection('users')
          .where('email', isEqualTo: information.email)
          .get();

      if (users.docs.isEmpty) {
        // No user with the same email exists, so add the new user
        int userId = rng.nextInt(1 << 32);
        AppConstants.id = userId;
        var user = UserModelSave(
          id: userId,
          name: information.displayName ?? '',
          email: information.email ?? '',
          phone: '',
          type: 'Customer',
          avatar: information.photoURL ?? '',
          localedType: '',
          token: '',
          isOnline: true,
          lastSeen: DateTime.now(),
          deviceToken: AppConstants.deviceToken!,
        );
        var userDoc = await firestore
            .collection('users')
            .doc(AppConstants.id.toString())
            .get();
        if (userDoc.exists) {
          await firestore
              .collection('users')
              .doc(AppConstants.id.toString())
              .update(user.toJson());
        } else {
          await firestore
              .collection('users')
              .doc(AppConstants.id.toString())
              .set(user.toJson());
        }
      } else {
        AppConstants.id = users.docs.first.get('id');
        print("this is current${AppConstants.id}");
      }
    }
    AppConstants.token = credential.accessToken.toString();
  }
*/
  @override
  Future<void> googleAuth() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        debugPrint('User cancelled sign-in');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      String? accessToken = googleAuth.accessToken;

       await dio.postData(
        data: {
          "access_token": accessToken,
        },
        url: Endpoints.firebaseLogin,
      );

    } on PlatformException catch (e) {
      if (e.code == 'sign_in_failed') {
        debugPrint('Google Sign-In failed.');
      }
      rethrow;
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> facebookAuth() async {
    try {
      final LoginResult loginResult = await faceBookAuth.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

    } on PlatformException catch (e) {
      if (e.code == 'sign_in_failed') {
        debugPrint('Google Sign-In failed.');
      }
      rethrow;
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<UserModel> signIn(SignInParams params) async {
    try {
      Response response = await dio.postData(
        data: params.toJson(),
        url: Endpoints.login,
      );
      UserModel userModel = UserModel.fromJson(response.data);
      return userModel;
    } on DioException catch (error) {
      debugPrint('DioException occurred: ${error.message}');
      if (error.response != null) {
        debugPrint('HTTP status code: ${error.response?.statusCode}');
        debugPrint('Response data: ${error.response?.data}');
      } else {
        debugPrint('Response is null');
      }
      debugPrint('Request info: ${error.requestOptions}');
      rethrow;
    } catch (e) {
      debugPrint('An unexpected error occurred: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<String> getCurrentUid() async => auth.currentUser!.uid;

  @override
  Future<UserModelSave> getCurrentUser() async {
    var userData = await firestore
        .collection('users')
        .doc(AppConstants.id.toString())
        .get();
    UserModelSave user = UserModelSave.fromMap(userData.data()!);
    return user;
  }

 /* @override
  Future<void> saveUserDataToFirebase(UserEntity userModel) async {
    String id = userModel.id.toString();
    var user = UserModelSave(
      id: userModel.id!,
      name: userModel.name!,
      email: userModel.email!,
      phone: userModel.phone!,
      type: userModel.type!,
      avatar: userModel.avatar!,
      localedType: userModel.localedType!,
      token: userModel.token!,
      isOnline: true,
      lastSeen: DateTime.now(),
      deviceToken: AppConstants.deviceToken!,
    );
    var userDoc = await firestore.collection('users').doc(id).get();
    if (userDoc.exists) {
      await firestore.collection('users').doc(id).update(user.toJson());
    } else {
      await firestore.collection('users').doc(id).set(user.toJson());
    }
  }*/

  Future<String> _storeFileToFirebase(String path, File file) async {
    UploadTask uploadTask = storage.ref().child(path).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  /* @override
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw ErrorHandler.handle(e);
    } catch (error, s) {
      debugPrintStack(stackTrace: s);

      throw ErrorHandler.handle(error);
    }
  }
*/
  @override
  Future<UserModel> signUp(SignUpParams user) async {
    try {
      final response = await dio.postData(
        url: Endpoints.register,
        data: user.toJson(),
      );
      final userModel = UserModel.fromJson(response.data);
      return userModel;
    } on DioException catch (error) {
      debugPrint(error.message);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }


}
