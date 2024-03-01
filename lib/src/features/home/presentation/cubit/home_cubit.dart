import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/features/auth/domain/entities/user_entity.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_up_usecase.dart';
import 'package:schmitt/src/features/booking/presentation/screens/booking_screen.dart';
import 'package:schmitt/src/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:schmitt/src/features/home/domain/use_cases/add_bokmark_usecase.dart';
import 'package:schmitt/src/features/home/domain/use_cases/bokmark_usecase.dart';
import 'package:schmitt/src/features/home/domain/use_cases/delete_bokmark_usecase.dart';
import 'package:schmitt/src/features/home/domain/use_cases/delete_notifications_usecase.dart';
import 'package:schmitt/src/features/home/domain/use_cases/get_services_use_case.dart';
import 'package:schmitt/src/features/home/domain/use_cases/get_slides_use_case.dart';
import 'package:schmitt/src/features/home/domain/use_cases/get_user_by_id_usecase.dart';
import 'package:schmitt/src/features/home/domain/use_cases/mark_all_seen_usecase.dart';
import 'package:schmitt/src/features/home/domain/use_cases/notifications_usecase.dart';
import 'package:schmitt/src/features/home/domain/use_cases/show_profile_usecase.dart';
import 'package:schmitt/src/features/home/domain/use_cases/update_profile_usecase.dart';
import 'package:schmitt/src/features/inbox/presentation/screens/inbox_screen.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';
import 'package:schmitt/src/features/home/presentation/screens/home_layout.dart';
import 'package:schmitt/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:schmitt/src/features/home/domain/entities/slides.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(
      {required this.getUserByIdUseCase,
      required this.bookMarkListUseCase,
      required this.markAllSeenListUseCase,
      required this.getServicesUseCase,
      required this.notificationsListUseCase,
      required this.deleteNotificationsListUseCase,
      required this.updateProfileUseCase,
      required this.deleteBookMarkListUseCase,
      required this.addBookMarkListUseCase,
      required this.getSlidesUseCase,
      required this.showProfileUseCase})
      : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  final ShowProfileUseCase showProfileUseCase;
  final BookMarkListUseCase bookMarkListUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;
  final DeleteBookMarkListUseCase deleteBookMarkListUseCase;
  final AddBookMarkListUseCase addBookMarkListUseCase;
  final MarkAllSeenListUseCase markAllSeenListUseCase;
  final NotificationsListUseCase notificationsListUseCase;
  final DeleteNotificationsListUseCase deleteNotificationsListUseCase;
  final GetSlidesUseCase getSlidesUseCase;
  final GetServicesUseCase getServicesUseCase;
  bool isDark = false;
  bool switchValue = true;

  int currentIndex = 0;
  int tabbedOffer = 0;
  int tabbedBook = 0;
  List<String> titles = ["home", "bookings", "calendar", "inbox", "profile"];
  List<String> offersList = [
    "all",
    "housekeepings",
    "carWash",
    "babySitting",
  ];

  List<Widget> screens = [
    const HomeLayoutScreen(),
    const BookingScreen(),
    const CalendarScreen(),
    const InboxScreen(),
    const ProfileScreen(),
  ];
  void appStarted() {
    emit(AppStartedState());
  }

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(HomeNavigationBarChanged(index));
  }

  changeTabbedOffer(int index) {
    tabbedOffer = index;
    emit(HomeTabbedOfferChanged(index));
  }

  changeTabbedBook(int index) {
    tabbedBook = index;
    emit(HomeTabbedBookChanged(index));
  }

  Future<void> updateProfile(SignUpParams params) async {
    emit(UpdateProfileLoading());

    final result = await updateProfileUseCase.call(params);
    result.fold(
        (failure) => emit(UpdateProfileErorr(
              message: failure.message,
            )), (right) {
      emit(UpdateProfileLoaded(right));
    });
  }

  Future<void> showProfile() async {
    emit(ShowProfileLoding());

    final result = await showProfileUseCase.call();
    result.fold(
      (failure) => emit(ShowProfileError(
        message: failure.message,
      )),
      (right) {
        AppConstants.profile = right;
        emit(ShowProfileLoaded(right));
      },
    );
  }

  List<Service>? bookmarks = [];
  Future<void> getBookMark(String category) async {
    emit(GetFavouriteLoding());

    final result = await bookMarkListUseCase.call(category);
    result.fold(
      (failure) => emit(GetFavouriteError(
        message: failure.message,
      )),
      (right) {
        bookmarks = right.data;
        emit(GetFavouriteLoaded(right.data));
      },
    );
  }

  Future<void> addBookMark(String id) async {
    emit(AddFavouriteLoding());

    final result = await addBookMarkListUseCase.call(id);
    result.fold(
      (failure) => emit(AddFavouriteError(
        message: failure.message,
      )),
      (right) {
        emit(AddFavouriteLoaded(message: right));
      },
    );
  }

  Future<void> deleteBookMark(String id) async {
    emit(DeleteFavouriteLoding());

    final result = await deleteBookMarkListUseCase.call(id);
    result.fold(
      (failure) => emit(DeleteFavouriteError(
        message: failure.message,
      )),
      (right) {
        emit(DeleteFavouriteLoaded(message: right));
      },
    );
  }

  Future<void> getNotificationsList() async {
    emit(GetNotificationLoading());

    final result = await notificationsListUseCase.call();
    result.fold(
      (failure) => emit(GetNotificationError(
        message: failure.message,
      )),
      (right) {
        emit(GetNotificationLoaded(right));
      },
    );
  }

  Future<void> markAllSeen() async {
    emit(MarkAllSeenLoading());

    final result = await markAllSeenListUseCase.call();
    result.fold(
      (failure) => emit(MarkAllSeenError(
        message: failure.message,
      )),
      (right) {
        emit(MarkAllSeenLoaded(message: right));
      },
    );
  }

  Future<void> deleteNotification(String id) async {
    emit(DeleteNotificationLoding());

    final result = await deleteNotificationsListUseCase.call(id);
    result.fold(
      (failure) => emit(DeleteNotificationError(
        message: failure.message,
      )),
      (right) {
        emit(DeleteNotificationLoaded(message: right));
      },
    );
  }

  List<Slide> slides = [];
  Future<void> getSlides(String id) async {
    emit(SlidesLoading());

    final result = await getSlidesUseCase.call(id);
    result.fold(
      (failure) => emit(SlidesError(
        message: failure.message,
      )),
      (right) {
        slides = right.data;
        emit(SlidesLoaded());
      },
    );
  }

  List<Service>? services = [];
  Future<void> getServices(int page, String id, String category) async {
    emit(ServicesLoading());

    final result = await getServicesUseCase.call(page, id, category);
    result.fold(
      (failure) => emit(ServicesError(
        message: failure.message,
      )),
      (right) {
        services = right.data;
        emit(ServicesLoaded(right.data));
      },
    );
  }

  Future<void> getCategoryServices(int page, String id, String category) async {
    emit(ServicesLoading());

    final result = await getServicesUseCase.call(page, id, category);
    result.fold(
      (failure) => emit(ServicesError(
        message: failure.message,
      )),
      (right) {
        emit(ServicesLoaded(right.data));
      },
    );
  }

  Stream<UserEntity> getUserById(String id) {
    return getUserByIdUseCase(id);
  }

  void changeTheme() {
    isDark = !isDark;
    switchValue = !switchValue;
    emit(ChangeColorMode());
  }
}
