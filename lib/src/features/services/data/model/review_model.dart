import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/models/meta_model.dart';
import 'package:schmitt/src/features/services/domain/entities/review.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    List<Review>? data,
    Meta? meta,
  }) : super(
          data: data,
          meta: meta,
        );

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      data: (json['data'] as List?)
          ?.map((i) => ReviewDataModel.fromJson(i as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] != null
          ? MetaModel.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ReviewDataModel extends Review {
  bool isLiked;
  int likes;
  ReviewDataModel({
    int? id,
    String? review,
    int? rating,
    Author? author,
    String? createdAt,
    String? createdAtFormatted,
    required this.isLiked,
    required this.likes,
  }) : super(
          id: id,
          review: review,
          rating: rating,
          author: author,
          createdAt: createdAt,
          createdAtFormatted: createdAtFormatted,
          isLiked: isLiked,
          likes: likes,
        );

  factory ReviewDataModel.fromJson(Map<String, dynamic> json) {
    return ReviewDataModel(
      id: json['id'] as int?,
      review: json['review'] as String?,
      rating: json['rating'] as int?,
      author: json['author'] != null
          ? AuthorModel.fromJson(json['author'] as Map<String, dynamic>)
          : null,
      createdAt: json['created_at'] as String?,
      createdAtFormatted: json['created_at_formatted'] as String?,
      isLiked: json['is_liked'] as bool? ?? false,
      likes: json['likes'] as int? ?? 0,
    );
  }
}

class AuthorModel extends Author {
  const AuthorModel({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? type,
    String? avatar,
    String? localedType,
    String? createdAt,
    String? createdAtFormatted,
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
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      type: json['type'] as String?,
      avatar: json['avatar'] as String?,
      localedType: json['localed_type'] as String?,
      createdAt: json['created_at'] as String?,
      createdAtFormatted: json['created_at_formatted'] as String?,
    );
  }
}
