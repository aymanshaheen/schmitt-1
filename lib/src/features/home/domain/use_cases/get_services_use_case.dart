import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/home/domain/repositories/home_repository.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';

class GetServicesUseCase {
  GetServicesUseCase({required this.repository});
  final HomeRepository repository;

  ResultFuture<ServiceEntity> call(int page, String id, String category) {
    return repository.getServices(page, id, category);
  }
}
