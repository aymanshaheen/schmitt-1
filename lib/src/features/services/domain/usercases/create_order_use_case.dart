import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/services/domain/repository/user_repository.dart';

class CreateOrderUseCase {
  CreateOrderUseCase({required this.repository});
  final ServiceRepository repository;

  ResultFuture<OrderEntity> call(OrderParams params,String addressId) {
    return repository.createOrder(params,addressId);
  }
}

class OrderParams extends Equatable {
  final String name;
  final int price;
  final int addressId;
  final int? carId;
  final int? packageId;
  final List<ServiceParams>? services;
  final List<dynamic>? microServices;
  final int? couponId;

  const OrderParams({
    required this.name,
    required this.price,
    required this.addressId,
    this.carId,
    this.packageId,
    this.services,
    this.microServices,
    this.couponId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'address_id': addressId,
      'car_id': carId,
      'package_id': packageId,
      'services': services!.map((service) => service.toJson()).toList(),
      'micro_services': microServices,
      'coupon_id': couponId,
    };
  }

  @override
  List<Object?> get props => [
        name,
        price,
        addressId,
        carId,
        packageId,
        services,
        microServices,
        couponId
      ];
}

class ServiceParams extends Equatable {
  final int id;
  final int inCartCount;

  const ServiceParams({
    required this.id,
    required this.inCartCount,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'in_cart_count': inCartCount,
    };
  }

  @override
  List<Object?> get props => [id, inCartCount];
}
