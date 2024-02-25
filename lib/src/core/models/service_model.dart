import 'package:schmitt/src/core/entities/service.dart';

class ServiceModel extends ServiceEntity {
  const ServiceModel({
    required int id,
    required String name,
    required String description,
    required int price,
    required String duration,
    required int inCartCount,
    required String createdAt,
    required String createdAtFormatted,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          duration: duration,
          inCartCount: inCartCount,
          createdAt: createdAt,
          createdAtFormatted: createdAtFormatted,
        );

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      duration: json['duration'],
      inCartCount: json['in_cart_count'],
      createdAt: json['created_at'],
      createdAtFormatted: json['created_at_formatted'],
    );
  }
}
class MicroServiceModel extends MicroServiceEntity {
  const MicroServiceModel({
    required int id,
    required String name,
    required String description,
    required int price,
    required String duration,
    required int inCartCount,
    required String createdAt,
    required String createdAtFormatted,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          duration: duration,
          inCartCount: inCartCount,
          createdAt: createdAt,
          createdAtFormatted: createdAtFormatted,
        );

  factory MicroServiceModel.fromJson(Map<String, dynamic> json) {
    return MicroServiceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      duration: json['duration'],
      inCartCount: json['in_cart_count'],
      createdAt: json['created_at'],
      createdAtFormatted: json['created_at_formatted'],
    );
  }
}
