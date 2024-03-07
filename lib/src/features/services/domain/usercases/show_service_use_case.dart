import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';
import 'package:schmitt/src/features/services/domain/repository/user_repository.dart';

class ShowServicesUseCase {
  ShowServicesUseCase({required this.repository});
  final ServiceRepository repository;

  ResultFuture<ServiceShowEntity> call(int page, String id) {
    return repository.getService(page, id);
  }
}
