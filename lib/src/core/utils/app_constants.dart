import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';
import 'package:camera/camera.dart';
import 'package:schmitt/src/features/services/domain/entities/adresses.dart';
import 'package:schmitt/src/features/services/domain/entities/car.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';

class AppConstants {
  AppConstants._();
  static const String baseUrl = "https://schmitt.elnoorphp.com/api/";
  static const String sendNotificationUrl = "https://fcm.googleapis.com/fcm/send";
  static const String serverToken = "key=AAAAn2pQ6uA:APA91bEkkdW6CiVQCGAqfTATfP0WTeH1b75usa5X5S1TN88d0wgdMLdUovi5H5Ij6PMRPILVL-Lyc3mw6hqGBDdJXgx48t46oMvypUd9e_jn_im1nEM2X5-RaWoy0keG1_15z4_OWXcC";
  static const int timeOutDuration = 90;
  static const int maxNameLength = 3;
  static String token = "";
  static String addressID = "15";
  static int id=0;
  static int addressId=0; 
  static int? selectEdit;
  static CarDataEntity? currentCar;
  static Address? currentAddress;
  static UserEntity? profile;
  static UserEntity? currentUser;
  static bool socialAuth = false;
  static String? selectedType="female";
  static String date = "";
  static String country = "United Arab Emirates";
  static late List<CameraDescription> cameras;
  static String? deviceToken;
  static  DateTime? selectedDate;
  static  int? selectedHour;
  static Service? service;
}
