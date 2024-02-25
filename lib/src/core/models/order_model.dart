import 'package:schmitt/src/core/entities/address.dart';
import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/entities/service.dart';
import 'package:schmitt/src/core/models/address_model.dart';
import 'package:schmitt/src/core/models/meta_model.dart';
import 'package:schmitt/src/core/models/service_model.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required List<OrderDataEntity> data,
    required Meta meta,
  }) : super(
          data: data,
          meta: meta,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      data: (json['data'] as List)
          .map((i) => OrderDataModel.fromJson(i))
          .toList(),
      meta: MetaModel.fromJson(json['meta']),
    );
  }
}

class OrderDataModel extends OrderDataEntity {
  const OrderDataModel({
    required int id,
    required String name,
    required int orderNum,
    required int price,
    required String status,
    required String type,
    required String car,
    required AddressEntity address,
    required String package,
    required List<ServiceEntity> services,
    required List<MicroServiceEntity> microServices,
    required String createdAt,
    required String createdAtFormatted,
  }) : super(
          id: id,
          name: name,
          orderNum: orderNum,
          price: price,
          status: status,
          type: type,
          car: car,
          address: address,
          package: package,
          services: services,
          microServices: microServices,
          createdAt: createdAt,
          createdAtFormatted: createdAtFormatted,
        );

  factory OrderDataModel.fromJson(Map<String, dynamic> json) {
    return OrderDataModel(
      id: json['id'],
      name: json['name'],
      orderNum: json['order_num'],
      price: json['price'],
      status: json['status'],
      type: json['type'],
      car: json['car'],
      address: AddressModel.fromJson(json['address']),
      package: json['package'],
      services: (json['services'] as List)
          .map((i) => ServiceModel.fromJson(i))
          .toList(),
      microServices: (json['micro_services'] as List)
          .map((i) => MicroServiceModel.fromJson(i))
          .toList(),
      createdAt: json['created_at'],
      createdAtFormatted: json['created_at_formatted'],
    );
  }
}
