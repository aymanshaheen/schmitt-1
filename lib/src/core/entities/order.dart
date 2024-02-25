import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/entities/address.dart';
import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/entities/service.dart';

class OrderEntity extends Equatable {
  final List<OrderDataEntity> data;
  final Meta meta;

  const OrderEntity({required this.data, required this.meta});

  @override
  List<Object> get props => [data, meta];
}

class OrderDataEntity extends Equatable {
  final int id;
  final String name;
  final int orderNum;
  final int price;
  final String status;
  final String type;
  final String car;
  final AddressEntity address;
  final String package;
  final List<ServiceEntity> services;
  final List<MicroServiceEntity> microServices;
  final String createdAt;
  final String createdAtFormatted;

  const OrderDataEntity({
    required this.id,
    required this.name,
    required this.orderNum,
    required this.price,
    required this.status,
    required this.type,
    required this.car,
    required this.address,
    required this.package,
    required this.services,
    required this.microServices,
    required this.createdAt,
    required this.createdAtFormatted,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        orderNum,
        price,
        status,
        type,
        car,
        address,
        package,
        services,
        microServices,
        createdAt,
        createdAtFormatted
      ];
}
