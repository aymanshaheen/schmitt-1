import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';
import 'package:schmitt/src/features/packages/domain/entities/package_entity.dart';
import 'package:schmitt/src/features/packages/domain/repositories/package_repository.dart';

class GetPackages {

  GetPackages({required this.repository});
  final PackageRepository repository;

  ResultFuture<PackageEntity> call() {
    return repository.getPackages();
  }
}

