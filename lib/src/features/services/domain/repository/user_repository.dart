import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/usecase/address_params.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/services/domain/entities/adresses.dart';
import 'package:schmitt/src/features/services/domain/entities/review.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_order_use_case.dart';

abstract class ServiceRepository {
  ResultFuture<ReviewEntity> getReviews(String id, String category);
  ResultFuture<String> addReview(String id, String review, String rating);
  ResultFuture<AddressEntity> getAdresses();
  ResultFuture<Address> createAddress(AddressParams params);
  ResultFuture<Service> getService(int id, String addressId,);
  ResultFuture<OrderEntity> createOrder(OrderParams params,String addressId);
}
