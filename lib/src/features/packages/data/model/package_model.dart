import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/models/meta_model.dart';

import '../../domain/entities/package_entity.dart';

class PackageModel extends PackageEntity {
  const PackageModel({
    required List<Data> data,
    required Meta meta,
  }) : super(
          data: data,
          meta: meta,
        );

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      data: (json['data'] as List).map((i) => DataModel.fromJson(i)).toList(),
      meta: MetaModel.fromJson(json['meta']),
    );
  }

}
class DataModel extends Data {
  final int? id;
  final String? name;
  final String? description;
  final int? washesCount;
  final int? days;
  final int? price;
  final bool? hasDiscount;
  final int? discountPrice;
  // final Authorize? authorize;
  final String? createdAt;
  final String? createdAtFormatted;

  const DataModel({
    this.id,
    this.name,
    this.description,
    this.washesCount,
    this.days,
    this.price,
    this.hasDiscount,
    this.discountPrice,
    // this.authorize,
    this.createdAt,
    this.createdAtFormatted,
  });
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      description: json['description'],
      price: json['price'],
      discountPrice: json['discount_price'],


      createdAt: json['created_at'],
      createdAtFormatted: json['created_at_formatted'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'price': price,
        'discount_price': discountPrice,
        'created_at': createdAt,
        'created_at_formatted': createdAtFormatted,
      };
}

