import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';

// ignore: must_be_immutable
class UserModelSave extends UserEntity {
  UserModelSave({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String type,
    required String avatar,
    required String localedType,
    required String token,
    required bool isOnline,
    required DateTime lastSeen,
    required String deviceToken,
  }) : super(
          isOnline: isOnline,
          lastSeen: lastSeen,
          id: id,
          name: name,
          email: email,
          phone: phone,
          type: type,
          avatar: avatar,
          localedType: localedType,
          token: token,
          deviceToken: deviceToken,
        );

  factory UserModelSave.fromMap(Map<String, dynamic> json) {
    return UserModelSave(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      type: json['type'],
      avatar: json['avatar'],
      localedType: json['localedType'],
      token: json['token'],
      isOnline: json['isOnline'],
      lastSeen: DateTime.fromMillisecondsSinceEpoch(json['lastSeen']),
      deviceToken: json['deviceToken'],
    );
  }
  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'type': type,
        'avatar': avatar,
        'localedType': localedType,
        'createdAt': createdAt,
        'createdAtFormatted': createdAtFormatted,
        'token': token,
        'status': status,
        'isOnline': isOnline,
        'lastSeen': lastSeen!.millisecondsSinceEpoch,
        'deviceToken': deviceToken,
      };
}
