import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/entities/meta.dart';

class Notifications extends Equatable {
  final List<Data> data;
  final Links links;
  final Meta meta;

  const Notifications({required this.data, required this.links, required this.meta});



  @override
  List<Object> get props => [data, links, meta];
}

class Data extends Equatable {
  final int id;
  final String? title;
  final String description;
  final String price;
  final String discountPrice;
  final String? image;
  final List<dynamic> images;
  final String? fileType;
  final String videoUrl;
  final String? video;
  final bool isFavorited;
  final String createdAt;
  final String createdAtFormatted;

  const Data({
    required this.id,
    this.title,
    required this.description,
    required this.price,
    required this.discountPrice,
    this.image,
    required this.images,
    this.fileType,
    required this.videoUrl,
    this.video,
    required this.isFavorited,
    required this.createdAt,
    required this.createdAtFormatted,
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
        fileType,
        videoUrl,
        video,
        isFavorited,
        createdAt,
        createdAtFormatted
      ];
}

class Links extends Equatable {
  final String first;
  final String last;
  final String? prev;
  final String? next;

 const Links({required this.first, required this.last, this.prev, this.next});



  @override
  List<Object?> get props => [first, last, prev, next];
}

