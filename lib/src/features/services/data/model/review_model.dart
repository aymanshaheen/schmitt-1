import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/models/meta_model.dart';
import 'package:schmitt/src/features/services/domain/entities/review.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required List<Review> data,
    required Meta meta,
  }) : super(
          data: data,
          meta: meta,
        );

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      data: (json['data'] as List)
          .map((i) => ReviewDataModel.fromJson(i))
          .toList(),
      meta: MetaModel.fromJson(json['meta']),
    );
  }
}

class ReviewDataModel extends Review {
  const ReviewDataModel({
    required int id,
    required String review,
    required int rating,
    required Author author,
    required String createdAt,
    required String createdAtFormatted,
  }) : super(
          id: id,
          review: review,
          rating: rating,
          author: author,
          createdAt: createdAt,
          createdAtFormatted: createdAtFormatted,
        );

  factory ReviewDataModel.fromJson(Map<String, dynamic> json) {
    return ReviewDataModel(
      id: json['id'],
      review: json['review'],
      rating: json['rating'],
      author: AuthorModel.fromJson(json['author']),
      createdAt: json['created_at'],
      createdAtFormatted: json['created_at_formatted'],
    );
  }
}

class AuthorModel extends Author {
  const AuthorModel({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String type,
    required String avatar,
    required String localedType,
    required String createdAt,
    required String createdAtFormatted,
  }) : super(
          id: id,
          name: name,
          email: email,
          phone: phone,
          type: type,
          avatar: avatar,
          localedType: localedType,
          createdAt: createdAt,
          createdAtFormatted: createdAtFormatted,
        );

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      type: json['type'],
      avatar: json['avatar'],
      localedType: json['localed_type'],
      createdAt: json['created_at'],
      createdAtFormatted: json['created_at_formatted'],
    );
  }
}
