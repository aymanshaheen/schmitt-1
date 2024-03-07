import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/entities/meta.dart';

class PackageEntity extends Equatable {
  final List<Data> data;
  final Meta meta;

  const PackageEntity({required this.data, required this.meta});

  @override
  List<Object> get props => [data, meta];
}

class Data extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final int? washesCount;
  final int? days;
  final int? price;
  final bool? hasDiscount;
  final int? discountPrice;
  final String? createdAt;
  final String? createdAtFormatted;

  const Data({
    this.id,
    this.name,
    this.description,
    this.washesCount,
    this.days,
    this.price,
    this.hasDiscount,
    this.discountPrice,
    this.createdAt,
    this.createdAtFormatted,
  });
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'createdAt': createdAt,
    'createdAtFormatted': createdAtFormatted,
  };
  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        washesCount,
        days,
        price,
        hasDiscount,
        discountPrice,
        createdAt,
        createdAtFormatted
      ];
}
