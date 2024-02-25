import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/home/domain/entities/bookmark.dart';
import 'package:schmitt/src/features/home/domain/repositories/home_repository.dart';

class BookMarkListUseCase {

  BookMarkListUseCase({required this.repository});
  final HomeRepository repository;

  ResultFuture<BookMark> call() {
    return repository.bookmarkList();
  }
}

