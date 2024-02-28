import 'package:equatable/equatable.dart';

class ServiceOrderEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final int price;
  final String duration;
  final int inCartCount;
  final String createdAt;
  final String createdAtFormatted;

  const ServiceOrderEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.inCartCount,
    required this.createdAt,
    required this.createdAtFormatted,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        duration,
        inCartCount,
        createdAt,
        createdAtFormatted
      ];
}

class MicroServiceEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final int price;
  final String duration;
  final int inCartCount;
  final String createdAt;
  final String createdAtFormatted;

  const MicroServiceEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.inCartCount,
    required this.createdAt,
    required this.createdAtFormatted,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        duration,
        inCartCount,
        createdAt,
        createdAtFormatted
      ];
}
