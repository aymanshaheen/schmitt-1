import 'package:equatable/equatable.dart';
import 'package:schmitt/src/core/entities/meta.dart';

class ReviewEntity extends Equatable {
  final List<Review>? data;
  final Meta? meta;

  const ReviewEntity({this.data, this.meta});

  @override
  List<Object?> get props => [data, meta];
}

class Review extends Equatable {
  final int? id;
  final String? review;
  final int? rating;
  final Author? author;
  final String? createdAt;
  final String? createdAtFormatted;

  const Review({
    this.id,
    this.review,
    this.rating,
    this.author,
    this.createdAt,
    this.createdAtFormatted,
  });

  @override
  List<Object?> get props =>
      [id, review, rating, author, createdAt, createdAtFormatted];
}

class Author extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? type;
  final String? avatar;
  final String? localedType;
  final String? createdAt;
  final String? createdAtFormatted;

  const Author({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.type,
    this.avatar,
    this.localedType,
    this.createdAt,
    this.createdAtFormatted,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        type,
        avatar,
        localedType,
        createdAt,
        createdAtFormatted
      ];
}