import 'package:schmitt/src/features/services/data/model/review_model.dart';


abstract class ServiceRemoteDataSource {
  Future<ReviewModel> getReviwes(String id);
  Future<String> addReview(String id, String review, String rating);


}
