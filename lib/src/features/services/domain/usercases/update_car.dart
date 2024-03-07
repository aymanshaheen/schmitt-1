import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/services/domain/repository/user_repository.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_car.dart';

class UpdateCarUseCase {
  UpdateCarUseCase({required this.repository});
  final ServiceRepository repository;

  ResultVoid call(CarParams params,int id) {
    return repository.updateCar(params,id);
  }
}

