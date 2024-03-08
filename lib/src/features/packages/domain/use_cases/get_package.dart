import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/packages/domain/entities/package_entity.dart';
import 'package:schmitt/src/features/packages/domain/repositories/package_repository.dart';

class GetPackageUseCase {

  GetPackageUseCase({required this.repository});
  final PackageRepository repository;

  ResultFuture<PackageEntity> call(String id) {
    return repository.getPackage(id);
  }
}

