import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/services/domain/entities/car.dart';
import 'package:schmitt/src/features/services/domain/repository/user_repository.dart';

class GetCarsUseCase {
  GetCarsUseCase({required this.repository});
  final ServiceRepository repository;

  ResultFuture<CarEntity> call(int params) {
    return repository.getCars(params);
  }
}
