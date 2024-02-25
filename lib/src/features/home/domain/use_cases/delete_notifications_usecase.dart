import 'package:schmitt/src/core/usecase/base_use_case.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/home/domain/repositories/home_repository.dart';

class DeleteNotificationsListUseCase extends BaseUseCase<String, String>{

  DeleteNotificationsListUseCase({required this.repository});
  final HomeRepository repository;

  @override
  ResultFuture<String> call(String parameters) {
    return repository.deleteNotification(parameters);
  }
}

