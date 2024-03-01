import 'package:schmitt/src/core/utils/typedef.dart';
import 'package:schmitt/src/features/services/domain/entities/company.dart';
import 'package:schmitt/src/features/services/domain/repository/user_repository.dart';

class GetCompaniesUseCase {
  GetCompaniesUseCase({required this.repository});
  final ServiceRepository repository;

  ResultFuture<CompanyEntity> call(int page, String id) {
    return repository.getCompanies(page, id);
  }
}
