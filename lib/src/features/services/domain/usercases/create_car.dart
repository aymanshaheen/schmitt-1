import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/services/domain/repository/user_repository.dart';

class CreateCarUseCase {
  CreateCarUseCase({required this.repository});
  final ServiceRepository repository;

  ResultVoid call(CarParams params) {
    return repository.createCar(params);
  }
}

class CarParams extends Equatable {
  final String name;
  final String plate;
  final int companyId;
  final int carModelId;
  final int colorID;

  const CarParams({
    required this.name,
    required this.plate,
    required this.companyId,
    required this.carModelId,
    required this.colorID,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'plate': plate,
      'company_id': companyId,
      'car_model_id': carModelId,
      'color_id': colorID,
    };
  }

  @override
  List<Object?> get props => [
        name,
        plate,
        companyId,
        carModelId,
        colorID,
      ];
}
