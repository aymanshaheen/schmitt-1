import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/models/meta_model.dart';
import 'package:schmitt/src/features/services/data/model/service_model.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';
import '../../domain/entities/package_entity.dart';

class PackagesModel extends PackagesEntity {
   PackagesModel({
    List<PackageDataEntity>? data,
         Meta? meta,

  }) : super(
          data: data ?? [],
          meta: meta!,
        );

  factory PackagesModel.fromJson(Map<String, dynamic> json) {
    return PackagesModel(
      data: (json['data'] as List?)?.map((i) => DataModel.fromJson(i)).toList() ?? [],
      meta: MetaModel.fromJson(json['meta']),
    );
  }
}

class PackageModel extends PackageEntity {
   PackageModel({
    PackageDataEntity? data,
  }) : super(
          data: data ?? DataModel(),
        );

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      data: json['data'] != null ? DataModel.fromJson(json['data']) : DataModel(),
    );
  }
}
class DataModel extends PackageDataEntity {
  DataModel({
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
          authorize: authorize ?? Authorize(),
          createdAt: createdAt ?? '',
          createdAtFormatted: createdAtFormatted ?? '',
        );

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      washesCount: json['washes_count'] ?? 0,
      days: json['days'] ?? 0,
      price: json['price'] ?? 0,
      hasDiscount: json['has_discount'] ?? false,
      discountPrice: json['discount_price'] ?? 0,
      authorize: json['authorize'] != null ? AuthorizeModel.fromJson(json['authorize']) : AuthorizeModel(),
      createdAt: json['created_at'] ?? '',
      createdAtFormatted: json['created_at_formatted'] ?? '',
    );
  }
}