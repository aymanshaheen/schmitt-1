import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_up_usecase.dart';
import 'package:schmitt/src/features/home/domain/entities/bookmark.dart';
import 'package:schmitt/src/features/home/domain/entities/notification.dart';


abstract class HomeRepository {
  ResultFuture<UserEntity> showProfile();
  ResultFuture<BookMark> bookmarkList();
  ResultFuture<String> deleteBookMark(String id);
  ResultFuture<String> addBookMark(String id);
  ResultFuture<Notifications> notificationList();
  ResultFuture<String> deleteNotification(String id);
  ResultFuture<String> markAllSeen();
  ResultFuture<UserEntity> updateProfile(SignUpParams parameters);
  Stream<UserEntity> getUserById(String id);

}
