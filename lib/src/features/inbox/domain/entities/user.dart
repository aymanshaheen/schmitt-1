import 'package:equatable/equatable.dart';

class UserChatEntity extends Equatable {
  
  final String status;
  final bool isOnline;
  final List<String> groupId;
  final DateTime lastSeen;

  const UserChatEntity({
   
    required this.status,
   
    required this.isOnline,
    required this.groupId,
    required this.lastSeen,
  });

  @override
  List<Object?> get props => [
   
    status,
  
    isOnline,
    groupId,
    lastSeen,
  ];
}
