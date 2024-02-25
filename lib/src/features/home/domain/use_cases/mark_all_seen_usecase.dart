import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/home/domain/repositories/home_repository.dart';

class MarkAllSeenListUseCase {

 MarkAllSeenListUseCase({required this.repository});
  final HomeRepository repository;

  ResultFuture<String> call() {
    return repository.markAllSeen();
  }
}

