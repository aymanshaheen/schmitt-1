import '../../domain/entities/user.dart';

class UserChatModel extends UserChatEntity {
  const UserChatModel({
    required super.status,
    required super.isOnline,
    required super.groupId,
    required super.lastSeen,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'isOnline': isOnline,
      'groupId': groupId,
      'lastSeen': lastSeen.millisecondsSinceEpoch,
    };
  }

  factory UserChatModel.fromMap(Map<String, dynamic> map) {
    return UserChatModel(
      status: map['status'] ?? '',
      isOnline: map['isOnline'] ?? false,
      groupId: List<String>.from(map['groupId']),
      lastSeen: DateTime.fromMillisecondsSinceEpoch(map['lastSeen']),
    );
  }
}
