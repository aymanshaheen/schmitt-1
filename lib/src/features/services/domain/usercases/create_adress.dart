import 'package:schmitt/src/core/usecase/address_params.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/services/domain/entities/adresses.dart';
import 'package:schmitt/src/features/services/domain/repository/user_repository.dart';

class CreateAdressesUseCase {
  CreateAdressesUseCase({required this.repository});
  final ServiceRepository repository;

  ResultFuture<Address> call(AddressParams params) {
    return repository.createAddress(params);
  }
}
