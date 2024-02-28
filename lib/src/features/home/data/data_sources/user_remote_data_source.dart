import 'package:schmitt/src/features/auth/data/model/user_model.dart';
import 'package:schmitt/src/features/auth/data/model/user_model_save.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_up_usecase.dart';
import 'package:schmitt/src/features/home/data/model/notification_model.dart';
import 'package:schmitt/src/features/home/data/model/slides_model.dart';
import 'package:schmitt/src/features/services/data/model/service_model.dart';

abstract class HomeRemoteDataSource {
  Future<UserModel> showProfile();
  Future<ServiceModel> bookMarkList(String category);
  Future<String> deleteBookMark(String id);
  Future<String> addBookMark(String id);
  Future<NotificationsModel> notificationsList();
  Future<String> deleteNotification(String id);
  Future<String> markAllSeen();
  Stream<UserModelSave> getUserById(String id);
  Future<UserModel> updateProfile(SignUpParams parameters);
  Future<SliderModel> getSlides(String id);
  Future<ServiceModel> getServices(
      int pageNum, String addressId, String category);
}
