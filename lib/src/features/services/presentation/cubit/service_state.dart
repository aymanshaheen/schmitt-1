import 'package:schmitt/src/features/services/domain/entities/review.dart';

class ServiceStates {}

class ServiceInitial extends ServiceStates {}

class ServiceLoading extends ServiceStates {}

class ServiceLoaded extends ServiceStates {}

class ServiceError extends ServiceStates {
  final String message;
  ServiceError(this.message);
}
class StepUpdated extends ServiceStates {
  final int step;

  StepUpdated(this.step);
}
class ServiceNavigationBarChanged extends ServiceStates {
  final int index;
  ServiceNavigationBarChanged(this.index);
}
class RoomCountUpdated extends ServiceStates {}
class ServiceTabbedOfferChanged extends ServiceStates {
  final int index;
  ServiceTabbedOfferChanged(this.index);
}
class AddReviweLoading extends ServiceStates {}
class AddReviweLoaded extends ServiceStates {
  final String review;
  AddReviweLoaded(this.review);
}
class AddReviweError extends ServiceStates {
  final String message;
  AddReviweError(this.message);
}

class GetReviwesLoading extends ServiceStates {}
class GetReviwesLoaded extends ServiceStates {
  final List<Review> reviews;
  GetReviwesLoaded(this.reviews);
}
class GetReviwesError extends ServiceStates {
  final String message;
  GetReviwesError(this.message);
}