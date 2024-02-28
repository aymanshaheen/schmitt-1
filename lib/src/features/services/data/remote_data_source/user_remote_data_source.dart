import 'package:schmitt/src/core/usecase/address_params.dart';
import 'package:schmitt/src/features/services/data/model/adresses_model.dart';
import 'package:schmitt/src/features/services/data/model/review_model.dart';


abstract class ServiceRemoteDataSource {
  Future<ReviewModel> getReviwes(String id, String category);
  Future<String> addReview(String id, String review, String rating);
  Future<AddressModel> getAddresses();
  Future<AddressDataModel> createAddress(AddressParams params);


}
