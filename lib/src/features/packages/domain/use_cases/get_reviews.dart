import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/packages/domain/repositories/package_repository.dart';
import 'package:schmitt/src/features/services/domain/entities/review.dart';

class GetReviwesUseCase {
  GetReviwesUseCase({required this.repository});
  final PackageRepository repository;

  ResultFuture<ReviewEntity> call({required String id, required String category}) {
    return repository.getReviews(id,category);
  }
}
