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

class ServiceDataModel extends Service {
  const ServiceDataModel({
    required int id,
    required String title,
    required String description,
    required String price,
    required String discountPrice,
    required Image image,
    required List<Image> images,
    required bool isFavorited,
  }) : super(
          id: id,
          title: title,
          description: description,
          price: price,
          discountPrice: discountPrice,
          image: image,
          images: images,
          isFavorited: isFavorited,
        );

  factory ServiceDataModel.fromJson(Map<String, dynamic> json) {
    return ServiceDataModel(
      id: json['id'],
      title: json['title'] ,
      description: json['description'],
      price: json['price'],
      discountPrice: json['discount_price'],
      image: ImageModel.fromJson(json['image']) ,
      images:
          (json['images'] as List).map((i) => ImageModel.fromJson(i)).toList(),
      isFavorited: json['is_favorited'],
    );
  }
}

class ImageModel extends Image {
  const ImageModel({
    required int id,
    required String url,
    required String preview,
    required String name,
    required String fileName,
  }) : super(
          id: id,
          url: url,
          preview: preview,
          name: name,
          fileName: fileName,
        );

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      url: json['url'],
      preview: json['preview'],
      name: json['name'],
      fileName: json['file_name'],
    );
  }
}
