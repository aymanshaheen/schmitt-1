import 'package:schmitt/src/features/packages/data/model/package_model.dart';
import 'package:schmitt/src/features/services/data/model/review_model.dart';


abstract class PackageRemoteDataSource {
  Future<PackagesModel> getPackages();
  Future<PackageModel> getPackage(String id);
  Future<ReviewModel> getReviwes(String id, String category);
  Future<String> addReview(String id, String review, String rating);
}
