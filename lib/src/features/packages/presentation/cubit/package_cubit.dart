import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/features/packages/domain/entities/package_entity.dart';
import 'package:schmitt/src/features/packages/domain/use_cases/add_review.dart';
import 'package:schmitt/src/features/packages/domain/use_cases/get_package.dart';
import 'package:schmitt/src/features/packages/domain/use_cases/get_packages.dart';
import 'package:schmitt/src/features/packages/domain/use_cases/get_reviews.dart';
import 'package:schmitt/src/features/services/domain/entities/review.dart';
part 'package_states.dart';

class PackageCubit extends Cubit<PackageStates> {
  final GetPackageUseCase getPackageUseCase;
  final GetPackagesUseCase getPackagesUseCase;
  final AddReviweUseCase addReviweUseCase;
  final GetReviwesUseCase getReviwesUseCase;

  PackageCubit(
      {required this.getPackageUseCase,
      required this.getPackagesUseCase,
      required this.addReviweUseCase,
      required this.getReviwesUseCase})
      : super(PackageInitial());
  static PackageCubit get(context) => BlocProvider.of(context);

  List<PackageDataEntity> packages = [];
  Meta? metaPackages;
  Future<void> getPackages(int page) async {
    emit(PacakgesLoading());

    final result = await getPackagesUseCase.call(page);
    result.fold(
      (failure) => emit(PacakgesError(
        message: failure.message,
      )),
      (right) {
        packages.addAll(right.data);
        metaPackages = right.meta;
        emit(PacakgesLoaded(right.data));
      },
    );
  }

  PackageDataEntity? package;
  Future<void> getPackage(String id) async {
    emit(PacakgeLoading());

    final result = await getPackageUseCase.call(id);
    result.fold(
      (failure) => emit(PacakgeError(
        message: failure.message,
      )),
      (right) {
        package = right.data;
        emit(PacakgeLoaded(right.data));
      },
    );
  }

  Future<void> addReview(
      {required String id,
      required String review,
      required String rating}) async {
    emit(AddReviweLoading());

    final result =
        await addReviweUseCase.call(id: id, review: review, rating: rating);
    result.fold(
      (failure) => emit(AddReviweError(
        failure.message,
      )),
      (right) => emit(AddReviweLoaded(right)),
    );
  }

  List<Review>? reviews = [];
  Future<void> getReviews(String id, String category,int page) async {
    emit(GetReviwesLoading());

    final result = await getReviwesUseCase.call(id: id, category: category,page:page);
    result.fold(
        (failure) => emit(GetReviwesError(
              failure.message,
            )), (right) {
      reviews = right.data;
      emit(GetReviwesLoaded(right.data));
    });
  }

  Map<int, double> getReviewCounts() {
    Map<int, double> reviewCounts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};

    if (reviews != null) {
      for (var review in reviews!) {
        int rating = review.rating!;
        if (reviewCounts[rating] != null) {
          double count = reviewCounts[rating]!;
          count++;
          reviewCounts[rating] = count;
        } else {
          reviewCounts[rating] = 1;
        }
      }
    }

    return reviewCounts;
  }

  double getAverageRating() {
    if (reviews == null || reviews!.isEmpty) {
      return 0.0;
    }
    double total = 0.0;
    for (var review in reviews!) {
      total += review.rating!;
    }
    return (total / reviews!.length);
  }

  void likeReview(int index, bool isLiked) {
    if (isLiked) {
      reviews![index].isLiked = true;
      reviews![index].likes++;
    } else {
      reviews![index].isLiked = false;
      if (reviews![index].likes > 0) {
        reviews![index].likes--;
      }
    }
    emit(ReviewLiked(index, reviews![index].isLiked));
  }
}
