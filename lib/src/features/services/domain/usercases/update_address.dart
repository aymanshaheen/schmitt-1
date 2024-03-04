import 'package:schmitt/src/core/usecase/address_params.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/services/domain/repository/user_repository.dart';

class UpdateAddressUseCase {
  UpdateAddressUseCase({required this.repository});
  final ServiceRepository repository;

  ResultVoid call(AddressParams params,int id) {
    return repository.updateAddress(params,id);
  }
}

