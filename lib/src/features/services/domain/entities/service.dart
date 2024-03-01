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
  final String? discountPrice;
  final Category? category;
  final Image? image;
  final List<Image>? images;
  final String? fileType;
  final String? videoUrl;
  final bool? isFavorited;
  final Authorize? authorize;
  final String? createdAt;
  final String? createdAtFormatted;

  const Service({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.discountPrice,
    this.category,
    this.image,
    this.images,
    this.fileType,
    this.videoUrl,
    this.isFavorited,
    this.authorize,
    this.createdAt,
    this.createdAtFormatted,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        discountPrice,
        category,
        image,
        images,
        fileType,
        videoUrl,
        isFavorited,
        authorize,
        createdAt,
        createdAtFormatted,
      ];
}

class Category extends Equatable {
  final int? id;
  final String? name;
  final bool? isCar;
  final String? image;
  final String? createdAt;
  final String? createdAtFormatted;

  const Category({
    this.id,
    this.name,
    this.isCar,
    this.image,
    this.createdAt,
    this.createdAtFormatted,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        isCar,
        image,
        createdAt,
        createdAtFormatted,
      ];
}

class Image extends Equatable {
  final int? id;
  final String? url;
  final String? preview;
  final String? name;
  final String? fileName;
  final String? type;
  final String? mimeType;
  final int? size;
  final String? humanReadableSize;
  final Details? details;
  final String? status;
  final int? progress;
  final Links? links;

  const Image({
    this.id,
    this.url,
    this.preview,
    this.name,
    this.fileName,
    this.type,
    this.mimeType,
    this.size,
    this.humanReadableSize,
    this.details,
    this.status,
    this.progress,
    this.links,
  });

  @override
  List<Object?> get props => [
        id,
        url,
        preview,
        name,
        fileName,
        type,
        mimeType,
        size,
        humanReadableSize,
        details,
        status,
        progress,
        links,
      ];
}

class Details extends Equatable {
  final int? width;
  final int? height;
  final int? ratio;

  const Details({
    this.width,
    this.height,
    this.ratio,
  });

  @override
  List<Object?> get props => [width, height, ratio];
}

class Links extends Equatable {
  final Delete? delete;

  const Links({this.delete});

  @override
  List<Object?> get props => [delete];
}

class Delete extends Equatable {
  final String? href;
  final String? method;

  const Delete({this.href, this.method});

  @override
  List<Object?> get props => [href, method];
}

class Authorize extends Equatable {
  final bool? review;

  const Authorize({this.review});

  @override
  List<Object?> get props => [review];
}