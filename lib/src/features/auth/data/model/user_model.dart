import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';

// ignore: must_be_immutable
class UserModel extends UserEntity {
  UserModel({
    required int? id,
    required String? name,
    required String? email,
    required String? phone,
    required String? type,
    required String? avatar,
    required String? localedType,
    required String? createdAt,
    required String? createdAtFormatted,
    required String? token,
    String? message,
  }) : super(
          id: id!,
          name: name!,
          email: email!,
          phone: phone!,
          type: type!,
          avatar: avatar!,
          localedType: localedType!,
          createdAt: createdAt!,
          createdAtFormatted: createdAtFormatted!,
          token: token??'',
          message: message ?? '',
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['data']['id'],
      name: json['data']['name'],
      email: json['data']['email'],
      phone: json['data']['phone'],
      type: json['data']['type'],
      avatar: json['data']['avatar'],
      localedType: json['data']['localed_type'],
      createdAt: json['data']['created_at'],
      createdAtFormatted: json['data']['created_at_formatted'],
      token: json['token']??'',
      message: json['message'] ?? '',
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
        'message': message,
      };
}
