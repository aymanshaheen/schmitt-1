import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/home/domain/entities/notification.dart';
import 'package:schmitt/src/features/home/domain/repositories/home_repository.dart';

class NotificationsListUseCase {

  NotificationsListUseCase({required this.repository});
  final HomeRepository repository;

  ResultFuture<Notifications> call() {
    return repository.notificationList();
  }
}

