import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/models/meta_model.dart';
import 'package:schmitt/src/features/services/domain/entities/adresses.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required List<Address> data,
    required Meta meta,
  }) : super(
          data: data,
          meta: meta,
        );

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      data: (json['data'] as List)
          .map((i) => AddressDataModel.fromJson(i))
          .toList(),
      meta: MetaModel.fromJson(json['meta']),
    );
  }
}

class AddressDataModel extends Address {
  const AddressDataModel({
    required int id,
    required String name,
    required String address,
    required double locationLatitude,
    required double locationLongitude,
    String? city,
    String? area,
    required String createdAt,
    required String createdAtFormatted,
  }) : super(
          id: id,
          name: name,
          address: address,
          locationLatitude: locationLatitude,
          locationLongitude: locationLongitude,
          city: city,
          area: area,
          createdAt: createdAt,
          createdAtFormatted: createdAtFormatted,
        );

 factory AddressDataModel.fromJson(Map<String, dynamic> json) {
  return AddressDataModel(
    id: json['id'],
    name: json['name'],
    address: json['address'],
    locationLatitude: (json['location_latitude'] as num).toDouble(),
    locationLongitude: (json['location_longitude'] as num).toDouble(),
    city: json['city'] != null ? json['city']['name'] : "",
    area: json['area'] != null ? json['area']['name'] : "",
    createdAt: json['created_at'],
    createdAtFormatted: json['created_at_formatted'],
  );
}
}

class CityModel extends City {
  const CityModel({
    required int id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class AreaModel extends Area {
  const AreaModel({
    required int id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      id: json['id'],
      name: json['name'],
    );
  }
}