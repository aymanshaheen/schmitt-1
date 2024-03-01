import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/services/domain/entities/color.dart';
import 'package:schmitt/src/features/services/domain/repository/user_repository.dart';

class GetColorsUseCase {
  GetColorsUseCase({required this.repository});
  final ServiceRepository repository;

  ResultFuture<ColorEntity> call(String id) {
    return repository.getColors(id);
  }
}
