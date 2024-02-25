import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';
import 'package:schmitt/src/features/home/domain/entities/bookmark.dart';
import 'package:schmitt/src/features/home/domain/entities/notification.dart';

class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeNavigationBarChanged extends HomeStates {
  final int index;
  HomeNavigationBarChanged(this.index);
}

class HomeTabbedOfferChanged extends HomeStates {
  final int index;
  HomeTabbedOfferChanged(this.index);
}

class ShowProfileLoding extends HomeStates {}

class ShowProfileLoaded extends HomeStates {
  final UserEntity userModel;
  ShowProfileLoaded(this.userModel);
}

class ShowProfileError extends HomeStates {
  final String message;
  ShowProfileError({required this.message});
}

class UpdateProfileLoading extends HomeStates {}

class UpdateProfileLoaded extends HomeStates {
  final UserEntity userModel;
  UpdateProfileLoaded(this.userModel);
}

class UpdateProfileErorr extends HomeStates {
  final String message;
  UpdateProfileErorr({required this.message});
}

class GetFavouriteLoding extends HomeStates {}

class GetFavouriteLoaded extends HomeStates {
  final BookMark userModel;
  GetFavouriteLoaded(this.userModel);
}

class GetFavouriteError extends HomeStates {
  final String message;
  GetFavouriteError({required this.message});
}

class AddFavouriteLoding extends HomeStates {}

class AddFavouriteLoaded extends HomeStates {
  final String message;
  AddFavouriteLoaded({required this.message});
}

class AddFavouriteError extends HomeStates {
  final String message;
  AddFavouriteError({required this.message});
}

class DeleteFavouriteLoding extends HomeStates {}

class DeleteFavouriteLoaded extends HomeStates {
  final String message;
  DeleteFavouriteLoaded({required this.message});
}

class DeleteFavouriteError extends HomeStates {
  final String message;
  DeleteFavouriteError({required this.message});
}

class GetNotificationLoading extends HomeStates {}

class GetNotificationLoaded extends HomeStates {
  final Notifications userModel;
  GetNotificationLoaded(this.userModel);
}

class GetNotificationError extends HomeStates {
  final String message;
  GetNotificationError({required this.message});
}

class MarkAllSeenLoading extends HomeStates {}

class MarkAllSeenLoaded extends HomeStates {
  final String message;
  MarkAllSeenLoaded({required this.message});
}

class MarkAllSeenError extends HomeStates {
  final String message;
  MarkAllSeenError({required this.message});
}

class DeleteNotificationLoding extends HomeStates {}

class DeleteNotificationLoaded extends HomeStates {
  final String message;
  DeleteNotificationLoaded({required this.message});
}

class DeleteNotificationError extends HomeStates {
  final String message;
  DeleteNotificationError({required this.message});
}

class ChangeColorMode extends HomeStates {
  ChangeColorMode();
}
