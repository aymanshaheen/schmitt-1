import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/models/meta_model.dart';
import 'package:schmitt/src/features/services/domain/entities/adresses.dart';

class AddressModel extends AddressEntity {
   AddressModel({
    List<Address>? data,
    required Meta meta,
  }) : super(
          data: data ?? [],
          meta: meta ,
        );

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      data: (json['data'] as List?)
          ?.map((i) => AddressDataModel.fromJson(i))
          .toList() ?? [],
      meta:  MetaModel.fromJson(json['meta']) ,
    );
  }
}

class AddressDataModel extends Address {
  const AddressDataModel({
    int? id,
    String? name,
    String? address,
    double? locationLatitude,
    double? locationLongitude,
    String? city,
    String? area,
    String? createdAt,
    String? createdAtFormatted,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          address: address ?? '',
          locationLatitude: locationLatitude ?? 0.0,
          locationLongitude: locationLongitude ?? 0.0,
          city: city ?? '',
          area: area ?? '',
          createdAt: createdAt ?? '',
          createdAtFormatted: createdAtFormatted ?? '',
        );

  factory AddressDataModel.fromJson(Map<String, dynamic> json) {
    return AddressDataModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      locationLatitude: (json['location_latitude'] as num?)?.toDouble() ?? 0.0,
      locationLongitude: (json['location_longitude'] as num?)?.toDouble() ?? 0.0,
      city: json['city'] != null ? json['city']['name'] : "",
      area: json['area'] != null ? json['area']['name'] : "",
      createdAt: json['created_at'] as String? ?? '',
      createdAtFormatted: json['created_at_formatted'] as String? ?? '',
    );
  }
}

class CityModel extends City {
  const CityModel({
    int? id,
    String? name,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
        );

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}

class AreaModel extends Area {
  const AreaModel({
    int? id,
    String? name,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
        );

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}