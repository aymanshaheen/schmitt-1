import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/entities/meta.dart';

class BookMark extends Equatable {
  final List<Data> data;
  final Meta meta;

  const BookMark({required this.data,required this.meta});



  @override
  List<Object> get props => [data, meta];
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

