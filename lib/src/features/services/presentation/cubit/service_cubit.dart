import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/features/services/domain/usercases/add_review.dart';
import 'package:schmitt/src/features/services/domain/usercases/get_reviews.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_state.dart';

class ServiceCubit extends Cubit<ServiceStates> {
  final AddReviweUseCase addReviweUseCase;
  final GetReviwesUseCase getReviwesUseCase;
  ServiceCubit(
      {required this.addReviweUseCase, required this.getReviwesUseCase})
      : super(ServiceInitial());
  static ServiceCubit get(context) => BlocProvider.of(context);
  int tabbedOffer = 0;
  List<String> offersList = [
    "all".tr(),
    "5",
    "4",
    "3",
    "2",
    "1",
  ];
  List<String> roomsType = [
    "living_room",
    "bed_room",
    "kitchen",
    "bathroom",
    "other",
  ];
  List<int> roomsCount = [0, 0, 0, 0, 0];
  List<int> roomsPrice = [
    20,
    15,
    10,
    5,
    5,
  ];
  void decrementRoomCount(int index) {
    if (roomsCount[index] == 0) {
      return;
    }

    roomsCount[index]--;
    calculateTotalPrice();
    emit(RoomCountUpdated());
  }

  void incrementRoomCount(int index) {
    roomsCount[index]++;
    calculateTotalPrice();
    emit(RoomCountUpdated());
  }

  int calculateTotalPrice() {
    int total = 0;
    for (int i = 0; i < roomsCount.length; i++) {
      total += roomsCount[i] * roomsPrice[i];
    }
    return total;
  }

  int currentStep = 1;

  void updateStep(int step) {
    currentStep = step;
    emit(StepUpdated(currentStep));
  }

  changeTabbedOffer(int index) {
    tabbedOffer = index;
    emit(ServiceTabbedOfferChanged(index));
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

  Future<void> getReviews(String id) async {
    emit(GetReviwesLoading());

    final result = await getReviwesUseCase.call(id: id);
    result.fold(
      (failure) => emit(GetReviwesError(
        failure.message,
      )),
      (right) => emit(GetReviwesLoaded(right.data)),
    );
  }
}
