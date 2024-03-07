import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/entities/meta.dart';

class AddressEntity extends Equatable {
  final List<Address>? data;
  final Meta? meta;

  const AddressEntity({this.data, this.meta});

  @override
  List<Object?> get props => [data, meta];
}

class AddressCreateEntity extends Equatable {
  final Address? data;

  const AddressCreateEntity({this.data, });

  @override
  List<Object?> get props => [data, ];
}
class Address extends Equatable {
  final int id;
  final String? name;
  final String? address;
  final double? locationLatitude;
  final double? locationLongitude;
  final String? city;
  final String? area;
  final String? createdAt;
  final String? createdAtFormatted;

  const Address({
    required this.id,
    this.name,
    this.address,
    this.locationLatitude,
    this.locationLongitude,
    this.city,
    this.area,
    this.createdAt,
    this.createdAtFormatted,
  });

  @override
  List<Object?> get props =>
      [id, name, address, locationLatitude, locationLongitude, city, area, createdAt, createdAtFormatted];
}

class City extends Equatable {
  final int? id;
  final String? name;

  const City({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}

class Area extends Equatable {
  final int? id;
  final String? name;

  const Area({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}