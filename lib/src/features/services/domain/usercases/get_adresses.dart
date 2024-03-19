import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/services/domain/entities/adresses.dart';
import 'package:schmitt/src/features/services/domain/repository/user_repository.dart';

class GetAdressesUseCase {
  GetAdressesUseCase({required this.repository});
  final ServiceRepository repository;

  ResultFuture<AddressEntity> call(int page) {
    return repository.getAdresses(page);
  }
}
