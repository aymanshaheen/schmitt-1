import 'package:equatable/equatable.dart';

class AddressParams extends Equatable {
  final String name;
  final String address;
  final String locationLatitude;
  final String locatiogLongitude;

  const AddressParams({
    required this.address,
    required this.name,
    required this.locationLatitude,
    required this.locatiogLongitude,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'location_latitude': locationLatitude,
      'location_longitude': locatiogLongitude,
    };
  }

  @override
  List<Object?> get props =>
      [name, address, locationLatitude, locatiogLongitude];
}
