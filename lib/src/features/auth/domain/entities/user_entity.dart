import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? type;
  final String? avatar;
  final String? localedType;
  final String? createdAt;
  final String? createdAtFormatted;
  final String? token;
  final String? message;
  final String? status;
  final bool? isOnline;
  final List<String>? groupId;
  final DateTime? lastSeen;
  String? deviceToken;

  UserEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.type,
    this.status,
    this.isOnline,
    this.groupId,
    this.lastSeen,
    this.avatar,
    this.localedType,
    this.createdAt,
    this.createdAtFormatted,
    this.token,
    this.message,
    this.deviceToken,
  });

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
        'status': status,
        'isOnline': isOnline,
        'groupId': groupId,
        'lastSeen': lastSeen!.millisecondsSinceEpoch,
        'deviceToken': deviceToken,
      };
  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        type,
        avatar,
        localedType,
        createdAt,
        createdAtFormatted,
        token,
        message,
        status,
        isOnline,
        groupId,
        lastSeen,
        deviceToken,
      ];
}
