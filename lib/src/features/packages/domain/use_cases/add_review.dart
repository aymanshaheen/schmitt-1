import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/packages/domain/repositories/package_repository.dart';

class AddReviweUseCase {
  AddReviweUseCase({required this.repository});
  final PackageRepository repository;

  ResultFuture<String> call(
      {required String id, required String review, required String rating}) {
    return repository.addReview(id, review, rating);
  }
}
