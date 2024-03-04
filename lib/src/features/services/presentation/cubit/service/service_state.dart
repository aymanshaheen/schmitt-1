import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/features/services/domain/entities/adresses.dart';
import 'package:schmitt/src/features/services/domain/entities/car.dart';
import 'package:schmitt/src/features/services/domain/entities/color.dart';
import 'package:schmitt/src/features/services/domain/entities/company.dart';
import 'package:schmitt/src/features/services/domain/entities/review.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';

class ServiceStates {}

class ServiceInitial extends ServiceStates {}



class StepUpdated extends ServiceStates {
  final int step;

  StepUpdated(this.step);
}

class AddressUpdate extends ServiceStates {}

class ServiceNavigationBarChanged extends ServiceStates {
  final int index;
  ServiceNavigationBarChanged(this.index);
}
class ReviewLiked extends ServiceStates {
  final int index;
  final bool isLiked;

  ReviewLiked(this.index, this.isLiked);
}

class RoomCountUpdated extends ServiceStates {}

class ServiceTabbedOfferChanged extends ServiceStates {
  final int index;
  ServiceTabbedOfferChanged(this.index);
}
class ChangeDate extends ServiceStates {
  final DateTime index;
  ChangeDate(this.index);
}

class ChangeTime extends ServiceStates {
  final int index;
  ChangeTime(this.index);
}


class AddReviweLoading extends ServiceStates {}

class AddReviweLoaded extends ServiceStates {
  final String review;
  AddReviweLoaded(this.review);
}

class AddReviweError extends ServiceStates {
  final String message;
  AddReviweError(this.message);
}

class GetReviwesLoading extends ServiceStates {}

class GetReviwesLoaded extends ServiceStates {
  final List<Review>? reviews;
  GetReviwesLoaded(this.reviews);
}

class GetReviwesError extends ServiceStates {
  final String message;
  GetReviwesError(this.message);
}

class GetAddressesLoading extends ServiceStates {}

class GetAddressesLoaded extends ServiceStates {
  final List<Address>? addresses;
  GetAddressesLoaded(this.addresses);
}

class GetAddressesError extends ServiceStates {
  final String message;
  GetAddressesError(this.message);
}

class CreateAddressLoading extends ServiceStates {}

class CreateAddressLoaded extends ServiceStates {
  final Address address;
  CreateAddressLoaded(this.address);
}

class CreateAddressError extends ServiceStates {
  final String message;
  CreateAddressError(this.message);
}
class CreateOrderLoading extends ServiceStates {}

class CreateOrderLoaded extends ServiceStates {
  final OrderEntity address;
  CreateOrderLoaded(this.address);
}

class CreateOrderError extends ServiceStates {
  final String message;
  CreateOrderError(this.message);
}
class CreateCarLoading extends ServiceStates {}
class CreateCarLoaded extends ServiceStates {
}
class CreateCarError extends ServiceStates {
  final String message;
  CreateCarError(this.message);
}
class DeleteCarLoading extends ServiceStates {}
class DeleteCarLoaded extends ServiceStates {
}
class DeleteCarError extends ServiceStates {
  final String message;
  DeleteCarError(this.message);
}
class GetCarsLoading extends ServiceStates {}

class GetCarsLoaded extends ServiceStates {
  final List<CarDataEntity>? cars;
  GetCarsLoaded(this.cars);
}

class GetCarsError extends ServiceStates {
  final String message;
  GetCarsError(this.message);
}
class ShowCarLoading extends ServiceStates {}

class ShowCarLoaded extends ServiceStates {
  final CarDataEntity? car;
  ShowCarLoaded(this.car);
}

class ShowCarError extends ServiceStates {
  final String message;
  ShowCarError(this.message);
}
class GetColorsLoading extends ServiceStates {}

class GetColorsLoaded extends ServiceStates {
  final List<ColorData>? colors;
  GetColorsLoaded(this.colors);
}

class GetColorsError extends ServiceStates {
  final String message;
  GetColorsError(this.message);
}

class GetCompaniesLoading extends ServiceStates {}

class GetCompaniesLoaded extends ServiceStates {
  final List<Company>? companies;
  GetCompaniesLoaded(this.companies);
}

class GetCompaniesError extends ServiceStates {
  final String message;
  GetCompaniesError(this.message);
}
class ServicesLoading extends ServiceStates {}

class ServiceLoaded extends ServiceStates {
  final Service? services;
  ServiceLoaded(this.services);
}

class ServicesError extends ServiceStates {
  final String message;
  ServicesError({required this.message});
}
