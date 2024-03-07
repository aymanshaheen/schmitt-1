import 'package:schmitt/src/core/models/order_model.dart';
import 'package:schmitt/src/core/usecase/address_params.dart';
import 'package:schmitt/src/features/services/data/model/adresses_model.dart';
import 'package:schmitt/src/features/services/data/model/car_model.dart';
import 'package:schmitt/src/features/services/data/model/company_model.dart';
import 'package:schmitt/src/features/services/data/model/review_model.dart';
import 'package:schmitt/src/features/services/data/model/service_model.dart';
import 'package:schmitt/src/features/services/domain/entities/color.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_car.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_order_use_case.dart';

abstract class ServiceRemoteDataSource {
  Future<ReviewModel> getReviwes(String id, String category);
  Future<String> addReview(String id, String review, String rating);
  Future<AddressModel> getAddresses();
  Future<AddressCreateModel> createAddress(AddressParams params);
  Future<ServiceShowModel> getService(int id,String addressId,);
  Future<OrderModel> createOrder(OrderParams params,String addressId);
  Future<CarsModel> getCars(int page);
  Future<CarsShowModel> showCar(int id);
  Future<void> createCar(CarParams params);
  Future<void> updateCar(CarParams params,int id);
  Future<void> deleteCar(int id);
  Future<void> updateAddress(AddressParams params,int id);
  Future<void> deleteAddress(int id);
  Future<CompanyModel> getCompanies(int id,String addressId,);
  Future<ColorModel> getColors(String addressId,);

}
