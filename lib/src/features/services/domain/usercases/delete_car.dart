import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/services/domain/repository/user_repository.dart';

class DeleteCarUseCase {
  DeleteCarUseCase({required this.repository});
  final ServiceRepository repository;

  ResultVoid call(int id) {
    return repository.deleteCar(id);
  }
}

