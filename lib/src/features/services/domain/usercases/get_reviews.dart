import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/services/domain/entities/review.dart';
import 'package:schmitt/src/features/services/domain/repository/user_repository.dart';

class GetReviwesUseCase {
  GetReviwesUseCase({required this.repository});
  final ServiceRepository repository;

  ResultFuture<ReviewEntity> call({required String id, required String category}) {
    return repository.getReviews(id,category);
  }
}
