import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/usecase/address_params.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/services/domain/entities/adresses.dart';
import 'package:schmitt/src/features/services/domain/entities/car.dart';
import 'package:schmitt/src/features/services/domain/entities/color.dart';
import 'package:schmitt/src/features/services/domain/entities/company.dart';
import 'package:schmitt/src/features/services/domain/entities/review.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_car.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_order_use_case.dart';

abstract class ServiceRepository {
  ResultFuture<ReviewEntity> getReviews(String id, String category);
  ResultFuture<String> addReview(String id, String review, String rating);
  ResultFuture<AddressEntity> getAdresses(int page);
  ResultFuture<AddressCreateEntity> createAddress(AddressParams params);
  ResultFuture<ServiceShowEntity> getService(int id);
  ResultFuture<ColorEntity> getColors(String addressId,);
  ResultFuture<CompanyEntity> getCompanies(int id, String addressId,);
  ResultFuture<OrderEntity> createOrder(OrderParams params,String addressId);
  ResultFuture<CarEntity> getCars(int page);
  ResultFuture<CarShowEntity> showCar(int id);
  ResultVoid createCar(CarParams params);
  ResultVoid updateCar(CarParams params,int id);
  ResultVoid deleteCar(int id);
  ResultVoid updateAddress(AddressParams params,int id);
  ResultVoid deleteAddress(int id);
}
