import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/packages/domain/entities/package_entity.dart';
import 'package:schmitt/src/features/packages/domain/repositories/package_repository.dart';

class GetPackagesUseCase {

  GetPackagesUseCase({required this.repository});
  final PackageRepository repository;

  ResultFuture<PackagesEntity> call(int page) {
    return repository.getPackages(page);
  }
}

