import 'package:schmitt/src/core/utils/typedef.dart';

import 'package:schmitt/src/features/packages/domain/entities/package_entity.dart';


abstract class PackageRepository {
  ResultFuture<PackageEntity> getPackages();


}
