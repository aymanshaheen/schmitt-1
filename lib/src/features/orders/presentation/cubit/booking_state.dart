import 'package:schmitt/src/core/entities/order.dart';

class BookingStates {}

class BookingInitial extends BookingStates {}

class OrderLoading extends BookingStates {}

class OrderSuccess extends BookingStates {
  OrderSuccess(this.user);
  final List<Order>? user;
}

class OrderFailure extends BookingStates {
  final String message;

  OrderFailure({
    required this.message,
  });
}

class UpdateOrderLoading extends BookingStates {}

class UpdateOrderSuccess extends BookingStates {}

class UpdateOrderFailure extends BookingStates {
  final String message;

  UpdateOrderFailure({
    required this.message,
  });
}

class CancleOrderLoading extends BookingStates {
  List<Object> get props => [];
}

class CancleOrderSuccess extends BookingStates {
  List<Object> get props => [];
}

class CancleOrderFailure extends BookingStates {
  final String message;

  CancleOrderFailure({
    required this.message,
  });
}
