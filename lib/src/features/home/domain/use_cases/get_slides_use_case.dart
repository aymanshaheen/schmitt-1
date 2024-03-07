import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/home/domain/entities/slides.dart';
import 'package:schmitt/src/features/home/domain/repositories/home_repository.dart';

class GetSlidesUseCase {
  GetSlidesUseCase({required this.repository});
  final HomeRepository repository;

  ResultFuture<SliderEntity> call() {
    return repository.getSlides();
  }
}
