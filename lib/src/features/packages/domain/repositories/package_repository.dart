import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/packages/domain/entities/package_entity.dart';
import 'package:schmitt/src/features/services/domain/entities/review.dart';


abstract class PackageRepository {
  ResultFuture<PackagesEntity> getPackages(int page);
  ResultFuture<ReviewEntity> getReviews(String id, String category,int page);
  ResultFuture<String> addReview(String id, String review, String rating);
  ResultFuture<PackageEntity> getPackage(String id);

}
