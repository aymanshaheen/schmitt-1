import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/models/meta_model.dart';
import 'package:schmitt/src/features/home/domain/entities/bookmark.dart';

class NotificationsModel extends BookMark {
  const NotificationsModel({
    required List<Data> data,
    required Meta meta,
  }) : super(
          data: data,
          meta: meta,
        );

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      data: (json['data'] as List).map((i) => DataModel.fromJson(i)).toList(),
      meta: MetaModel.fromJson(json['meta']),
    );
  }

}
class DataModel extends Data {
  const DataModel({
    required int id,
    String? title,
    required String description,
    required String price,
    required String discountPrice,
    String? image,
    required List<dynamic> images,
    String? fileType,
    required String videoUrl,
    String? video,
    required bool isFavorited,
    required String createdAt,
    required String createdAtFormatted,
  }) : super(
          id: id,
          title: title,
          description: description,
          price: price,
          discountPrice: discountPrice,
          image: image,
          images: images,
          fileType: fileType,
          videoUrl: videoUrl,
          video: video,
          isFavorited: isFavorited,
          createdAt: createdAt,
          createdAtFormatted: createdAtFormatted,
        );

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      discountPrice: json['discount_price'],
      image: json['image'],
      images: json['images'],
      fileType: json['file_type'],
      videoUrl: json['video_url'],
      video: json['video'],
      isFavorited: json['is_favorited'],
      createdAt: json['created_at'],
      createdAtFormatted: json['created_at_formatted'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'discount_price': discountPrice,
        'image': image,
        'images': images,
        'file_type': fileType,
        'video_url': videoUrl,
        'video': video,
        'is_favorited': isFavorited,
        'created_at': createdAt,
        'created_at_formatted': createdAtFormatted,
      };
}
