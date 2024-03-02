import 'package:dartz/dartz.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/error/error_handler.dart';
import 'package:schmitt/src/features/packages/data/api_service/api_service.dart';
import 'package:schmitt/src/features/packages/data/repository/package_repository.dart';

class PackageRepoImpl implements PackageRepository {
  final ApiService apiService;

  PackageRepoImpl(this.apiService);
  @override
  Future<Either<Failure, List<Package>>> getPackages() async {
    try {
      var data = await apiService.get(endPoint: 'packages');
      List<Package> packages = [];

      return right(packages);
    } catch (e) {
      return left(Failure(message: e.toString(), code: 0));
    }
  }
}
