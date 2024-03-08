 part of 'package_cubit.dart';
 abstract class PackageStates extends Equatable {
   const PackageStates();

   @override
   List<Object> get props => [];
 }

 class PackageInitial extends PackageStates {}

 class AddReviweLoading extends PackageStates {}

class AddReviweLoaded extends PackageStates {
  final String review;
  const AddReviweLoaded(this.review);
}

class AddReviweError extends PackageStates {
  final String message;
  const AddReviweError(this.message);
}
class ReviewLiked extends PackageStates {
  final int index;
  final bool isLiked;

  const ReviewLiked(this.index, this.isLiked);
}
class GetReviwesLoading extends PackageStates {}

class GetReviwesLoaded extends PackageStates {
  final List<Review>? reviews;
  const GetReviwesLoaded(this.reviews);
}

class GetReviwesError extends PackageStates {
  final String message;
  const GetReviwesError(this.message);
}
class PacakgesLoading extends PackageStates {}

class PacakgesLoaded extends PackageStates {
  final List<PackageDataEntity> package;
  const PacakgesLoaded(this.package);
}

class PacakgesError extends PackageStates {
  final String message;
  const PacakgesError({required this.message});
}
class PacakgeLoading extends PackageStates {}

class PacakgeLoaded extends PackageStates {
  final PackageDataEntity? package;
  const PacakgeLoaded(this.package);
}

class PacakgeError extends PackageStates {
  final String message;
  const PacakgeError({required this.message});
}
