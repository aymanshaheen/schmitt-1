import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_up_usecase.dart';
import 'package:schmitt/src/features/home/domain/entities/notification.dart';
import 'package:schmitt/src/features/home/domain/entities/slides.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';


abstract class HomeRepository {
  ResultFuture<UserEntity> showProfile();
  ResultFuture<ServiceEntity> bookmarkList(String category);
  ResultFuture<String> deleteBookMark(String id);
  ResultFuture<String> addBookMark(String id);
  ResultFuture<Notifications> notificationList();
  ResultFuture<String> deleteNotification(String id);
  ResultFuture<String> markAllSeen();
  ResultFuture<UserEntity> updateProfile(SignUpParams parameters);
  Stream<UserEntity> getUserById(String id);
  ResultFuture<SliderEntity> getSlides(String id);
  ResultFuture<ServiceEntity> getServices(int pageNum,String addressId,String category);

}
