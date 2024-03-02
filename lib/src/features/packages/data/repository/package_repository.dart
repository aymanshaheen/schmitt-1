import 'package:dartz/dartz.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/error/error_handler.dart';


abstract class PackageRepository {
  Future<Either<Failure, List<Package>>> getPackages();

}