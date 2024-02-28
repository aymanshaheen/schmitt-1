import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/entities/meta.dart';

class ServiceEntity extends Equatable {
  final List<Service>? data;
  final Meta meta;

  const ServiceEntity({required this.data, required this.meta});

  @override
  List<Object> get props => [data!, meta];
}

class Service extends Equatable {
  final int id;
  final String title;
  final String description;
  final String price;
  final String discountPrice;
  final Image image;
  final List<Image> images;
  final bool isFavorited;

  const Service({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.image,
    required this.images,
    required this.isFavorited,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        discountPrice,
        image,
        images,
        isFavorited,
      ];
}

class Image extends Equatable {
  final int id;
  final String url;
  final String preview;
  final String name;
  final String fileName;

  const Image({
    required this.id,
    required this.url,
    required this.preview,
    required this.name,
    required this.fileName,
  });

  @override
  List<Object?> get props => [
        id,
        url,
        preview,
        name,
        fileName,
      ];
}
