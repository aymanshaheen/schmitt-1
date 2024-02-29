import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/models/meta_model.dart';
import 'package:schmitt/src/features/services/data/model/adresses_model.dart';
import 'package:schmitt/src/features/services/data/model/service_model.dart';
import 'package:schmitt/src/features/services/domain/entities/adresses.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    List<Order>? data,
    Meta?  meta,
  }) : super(
          data: data ?? [],
          meta: meta,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        data: (json['data'] as List?)
                ?.map((i) => OrderDataModel.fromJson(i as Map<String, dynamic>))
                .toList() ??
            [],
        meta: MetaModel.fromJson(json['meta'] as Map<String, dynamic>));
  }
}

class OrderDataModel extends Order {
  OrderDataModel({
    int? id,
    String? name,
    int? orderNum,
    int? taxPercentage,
    int? price,
    String? status,
    String? statusLocaled,
    String? type,
    Car? car,
    Coupon? coupon,
    Address? address,
    Package? package,
    List<Service>? services,
    Customer? customer,
    String? startAt,
    String? createdAt,
    String? createdAtFormatted,
    Authorize? authorize,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          orderNum: orderNum ?? 0,
          taxPercentage: taxPercentage ?? 0,
          price: price ?? 0,
          status: status ?? '',
          statusLocaled: statusLocaled ?? '',
          type: type ?? '',
          car: car ?? const Car(),
          coupon: coupon ?? const Coupon(),
          address: address ??const Address(),
          package: package ??const Package(),
          services: services ?? [],
          customer: customer ??const Customer(),
          startAt: startAt ?? '',
          createdAt: createdAt ?? '',
          createdAtFormatted: createdAtFormatted ?? '',
          authorize: authorize ??const Authorize(),
        );

  factory OrderDataModel.fromJson(Map<String, dynamic> json) {
    return OrderDataModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      orderNum: json['order_num'] ?? 0,
      taxPercentage: json['tax_percentage'] ?? 0,
      price: json['price'] ?? 0,
      status: json['status'] ?? '',
      statusLocaled: json['status_localed'] ?? '',
      type: json['type'] ?? '',
      car: json['car'] != null ? CarModel.fromJson(json['car']) :const Car(),
      coupon: json['coupon'] != null
          ? CouponModel.fromJson(json['coupon'])
          :const Coupon(),
      address: json['address'] != null
          ? AddressDataModel.fromJson(json['address'])
          :const Address(),
      package: json['package'] != null
          ? PackageModel.fromJson(json['package'])
          :const Package(),
      services: json['services'] != null
          ? (json['services'] as List)
              .map((i) => ServiceDataModel.fromJson(i))
              .toList()
          : [],
      customer: json['customer'] != null
          ? CustomerModel.fromJson(json['customer'])
          :const Customer(),
      startAt: json['start_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      createdAtFormatted: json['created_at_formatted'] ?? '',
      authorize: json['authorize'] != null
          ? AuthorizeModel.fromJson(json['authorize'])
          :const Authorize(),
    );
  }
}

class CarModel extends Car {
 const CarModel({int? id, String? name, String? plate})
      : super(id: id ?? 0, name: name ?? '', plate: plate ?? '');

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      plate: json['plate'] ?? '',
    );
  }
}

class CouponModel extends Coupon {
 const CouponModel({int? id, String? name}) : super(id: id ?? 0, name: name ?? '');

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class PackageModel extends Package {
 const PackageModel({
    int? id,
    String? name,
    String? description,
    int? washesCount,
    int? days,
    int? price,
    bool? hasDiscount,
    int? discountPrice,
    Authorize? authorize,
    String? createdAt,
    String? createdAtFormatted,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          description: description ?? '',
          washesCount: washesCount ?? 0,
          days: days ?? 0,
          price: price ?? 0,
          hasDiscount: hasDiscount ?? false,
          discountPrice: discountPrice ?? 0,
          authorize: authorize ??const Authorize(),
          createdAt: createdAt ?? '',
          createdAtFormatted: createdAtFormatted ?? '',
        );

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      washesCount: json['washes_count'] ?? 0,
      days: json['days'] ?? 0,
      price: json['price'] ?? 0,
      hasDiscount: json['has_discount'] ?? false,
      discountPrice: json['discount_price'] ?? 0,
      authorize: json['authorize'] != null
          ? AuthorizeModel.fromJson(json['authorize'])
          :const Authorize(),
      createdAt: json['created_at'] ?? '',
      createdAtFormatted: json['created_at_formatted'] ?? '',
    );
  }
}

class CustomerModel extends Customer {
const  CustomerModel({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? type,
    String? avatar,
    String? localedType,
    String? createdAt,
    String? createdAtFormatted,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          email: email ?? '',
          phone: phone ?? '',
          type: type ?? '',
          avatar: avatar ?? '',
          localedType: localedType ?? '',
          createdAt: createdAt ?? '',
          createdAtFormatted: createdAtFormatted ?? '',
        );

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      type: json['type'] ?? '',
      avatar: json['avatar'] ?? '',
      localedType: json['localed_type'] ?? '',
      createdAt: json['created_at'] ?? '',
      createdAtFormatted: json['created_at_formatted'] ?? '',
    );
  }
}

class AuthorizeModel extends Authorize {
 const AuthorizeModel({bool? cancel, bool? updateStartAt})
      : super(cancel: cancel ?? false, updateStartAt: updateStartAt ?? false);

  factory AuthorizeModel.fromJson(Map<String, dynamic> json) {
    return AuthorizeModel(
      cancel: json['cancel'] ?? false,
      updateStartAt: json['update_start_at'] ?? false,
    );
  }
}
