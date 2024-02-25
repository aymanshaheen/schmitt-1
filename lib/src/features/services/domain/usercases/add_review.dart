import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/services/domain/repository/user_repository.dart';

class AddReviweUseCase {
  AddReviweUseCase({required this.repository});
  final ServiceRepository repository;

  ResultFuture<String> call(
      {required String id, required String review, required String rating}) {
    return repository.addReview(id, review, rating);
  }
}
