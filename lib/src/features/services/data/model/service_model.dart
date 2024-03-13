import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/models/meta_model.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';

class ServiceModel extends ServiceEntity {
  const ServiceModel({
    required List<Service> data,
    required Meta meta,
  }) : super(
          data: data,
          meta: meta,
        );

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      data: (json['data'] as List)
          .map((i) => ServiceDataModel.fromJson(i))
          .toList(),
      meta: MetaModel.fromJson(json['meta']),
    );
  }
}

class ServiceShowModel extends ServiceShowEntity {
  const ServiceShowModel({
    required Service? data,
  }) : super(
          data: data,
        );

  factory ServiceShowModel.fromJson(Map<String, dynamic> json) {
    return ServiceShowModel(
      data: json['data'] != null
          ? ServiceDataModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ServiceDataModel extends Service {
  const ServiceDataModel({
    required int id,
    required String title,
    required String description,
    required String price,
    String? discountPrice,
    int? reviewsCount,
    Category? category,
    ImageData? image,
    List<ImageData>? images,
    String? fileType,
    String? videoUrl,
    bool? isFavorited,
    Authorize? authorize,
    String? createdAt,
    String? createdAtFormatted,
  }) : super(
          id: id,
          title: title,
          description: description,
          price: price,
          discountPrice: discountPrice,
          reviewsCount: reviewsCount,
          category: category,
          image: image,
          images: images,
          fileType: fileType,
          videoUrl: videoUrl,
          isFavorited: isFavorited,
          authorize: authorize,
          createdAt: createdAt,
          createdAtFormatted: createdAtFormatted,
        );

  factory ServiceDataModel.fromJson(Map<String, dynamic> json) {
    return ServiceDataModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      price: json['price'] ?? "",
      reviewsCount: json['reviews_count'] ?? 0,
      discountPrice: json['discount_price'] ?? "",
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      image: json['image'] != null
          ? ImageModel.fromJson(json['image'] as Map<String, dynamic>)
          : null,
      images: (json['images'] as List?)
          ?.map((i) => ImageModel.fromJson(i as Map<String, dynamic>))
          .toList(),
      fileType: json['file_type'] ?? "",
      videoUrl: json['video_url'] ?? "",
      isFavorited: json['is_favorited'] as bool?,
      authorize: json['authorize'] != null
          ? AuthorizeModel.fromJson(json['authorize'] as Map<String, dynamic>)
          : null,
      createdAt: json['created_at'] ?? "",
      createdAtFormatted: json['created_at_formatted'] ?? "",
    );
  }
}

class CategoryModel extends Category {
  const CategoryModel({
    int? id,
    String? name,
    bool? isCar,
    String? image,
    String? createdAt,
    String? createdAtFormatted,
  }) : super(
          id: id,
          name: name,
          isCar: isCar,
          image: image,
          createdAt: createdAt,
          createdAtFormatted: createdAtFormatted,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      isCar: json['is_car'] as bool?,
      image: json['image'] as String?,
      createdAt: json['created_at'] as String?,
      createdAtFormatted: json['created_at_formatted'] as String?,
    );
  }
}

class ImageModel extends ImageData {
  const ImageModel({
    num? id,
    String? url,
    String? preview,
    String? name,
    String? fileName,
    String? type,
    String? mimeType,
    String? humanReadableSize,
    String? status,
  }) : super(
          id: id,
          url: url,
          preview: preview,
          name: name,
          fileName: fileName,
          type: type,
          mimeType: mimeType,
          humanReadableSize: humanReadableSize,
          status: status,
        );

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] as num?,
      url: json['url'] as String?,
      preview: json['preview'] as String?,
      name: json['name'] as String?,
      fileName: json['file_name'] as String?,
      type: json['type'] as String?,
      mimeType: json['mime_type'] as String?,
      humanReadableSize: json['human_readable_size'] as String?,
      
      status: json['status'] as String?,
 
    );
  }
}






class AuthorizeModel extends Authorize {
  const AuthorizeModel({
    bool? review,
  }) : super(
          review: review,
        );

  factory AuthorizeModel.fromJson(Map<String, dynamic> json) {
    return AuthorizeModel(
      review: json['review'] as bool?,
    );
  }
}
