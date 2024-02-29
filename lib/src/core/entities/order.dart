import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/features/services/domain/entities/adresses.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';

class OrderEntity extends Equatable {
  final List<Order>? data;
  final Meta? meta;

  const OrderEntity({this.data, this.meta});

  @override
  List<Object?> get props => [data, meta];
}

class Order extends Equatable {
  final int? id;
  final String? name;
  final int? orderNum;
  final int? taxPercentage;
  final int? price;
  final String? status;
  final String? statusLocaled;
  final String? type;
  final Car? car;
  final Coupon? coupon;
  final Address? address;
  final Package? package;
  final List<Service>? services;
  final Customer? customer;
  final String? startAt;
  final String? createdAt;
  final String? createdAtFormatted;
  final Authorize? authorize;

  const Order({
    this.id,
    this.name,
    this.orderNum,
    this.taxPercentage,
    this.price,
    this.status,
    this.statusLocaled,
    this.type,
    this.car,
    this.coupon,
    this.address,
    this.package,
    this.services,
    this.customer,
    this.startAt,
    this.createdAt,
    this.createdAtFormatted,
    this.authorize,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        orderNum,
        taxPercentage,
        price,
        status,
        statusLocaled,
        type,
        car,
        coupon,
        address,
        package,
        services,
        customer,
        startAt,
        createdAt,
        createdAtFormatted,
        authorize,
      ];
}

class Package extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final int? washesCount;
  final int? days;
  final int? price;
  final bool? hasDiscount;
  final int? discountPrice;
  final Authorize? authorize;
  final String? createdAt;
  final String? createdAtFormatted;

  const Package({
    this.id,
    this.name,
    this.description,
    this.washesCount,
    this.days,
    this.price,
    this.hasDiscount,
    this.discountPrice,
    this.authorize,
    this.createdAt,
    this.createdAtFormatted,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        washesCount,
        days,
        price,
        hasDiscount,
        discountPrice,
        authorize,
        createdAt,
        createdAtFormatted,
      ];
}

class Customer extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? type;
  final String? avatar;
  final String? localedType;
  final String? createdAt;
  final String? createdAtFormatted;

  const Customer({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.type,
    this.avatar,
    this.localedType,
    this.createdAt,
    this.createdAtFormatted,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        type,
        avatar,
        localedType,
        createdAt,
        createdAtFormatted,
      ];
}
class Car extends Equatable {
  final int? id;
  final String? name;
  final String? plate;

  const Car( {this.id,this.plate, this.name});

  @override
  List<Object?> get props => [id, name, plate];
}

class Coupon extends Equatable {
  final int? id;
  final String? name;

  const Coupon({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}

class Authorize extends Equatable {
  final bool? cancel;
  final bool? updateStartAt;

  const Authorize({this.cancel, this.updateStartAt});

  @override
  List<Object?> get props => [cancel, updateStartAt];
}