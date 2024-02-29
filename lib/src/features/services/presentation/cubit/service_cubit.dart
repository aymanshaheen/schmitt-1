import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/usecase/address_params.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/features/services/domain/entities/adresses.dart';
import 'package:schmitt/src/features/services/domain/entities/review.dart';
import 'package:schmitt/src/features/services/domain/usercases/add_review.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_adress.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_order_use_case.dart';
import 'package:schmitt/src/features/services/domain/usercases/get_adresses.dart';
import 'package:schmitt/src/features/services/domain/usercases/get_reviews.dart';
import 'package:schmitt/src/features/services/domain/usercases/show_service_use_case.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_state.dart';

class ServiceCubit extends Cubit<ServiceStates> {
  final AddReviweUseCase addReviweUseCase;
  final GetReviwesUseCase getReviwesUseCase;
  final ShowServicesUseCase getServicesUseCase;
  final CreateOrderUseCase createOrderUseCase;
  final GetAdressesUseCase getAdressesUseCase;
  final CreateAdressesUseCase createAdressesUseCase;
  ServiceCubit(
      {required this.addReviweUseCase,
      required this.createAdressesUseCase,
      required this.createOrderUseCase,
      required this.getAdressesUseCase,
      required this.getServicesUseCase,
      required this.getReviwesUseCase})
      : super(ServiceInitial());
  static ServiceCubit get(context) => BlocProvider.of(context);
  int tabbedOffer = 0;
  int? selectedAddressIndex;
  List<Address>? addresses = [];

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

  DateTime selectedDate = DateTime.now().add(const Duration(days: 0));
  int? selectedIndex;

  void setSelectedDate(DateTime date, int index) {
    selectedDate = date;
    selectedIndex = index;
    emit(ChangeDate(date));
  }

  int? selectedHour;
  void setSelectedHour(int hour) {
    selectedHour = hour;
    emit(ChangeTime(hour));
  }

  changeTabbedOffer(int index) {
    tabbedOffer = index;
    emit(ServiceTabbedOfferChanged(index));
  }

  Future<void> getServices(int page, String id) async {
    emit(ServicesLoading());

    final result = await getServicesUseCase.call(page, id);
    result.fold(
      (failure) => emit(ServicesError(
        message: failure.message,
      )),
      (right) {
        emit(ServicesLoaded(right));
      },
    );
  }

  void selectAddressIndex(int index) {
    selectedAddressIndex = index;
    AppConstants.addressId = addresses![index].id!;
    emit(AddressUpdate());
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
  Future<void> getReviews(String id, String category) async {
    emit(GetReviwesLoading());

    final result = await getReviwesUseCase.call(id: id, category: category);
    result.fold(
        (failure) => emit(GetReviwesError(
              failure.message,
            )), (right) {
      reviews = right.data;
      emit(GetReviwesLoaded(right.data));
    });
  }

  Future<void> getAdresses() async {
    emit(GetAddressesLoading());

    final result = await getAdressesUseCase.call();
    result.fold(
      (failure) => emit(GetAddressesError(
        failure.message,
      )),
      (right) {
        addresses = right.data;
        emit(GetAddressesLoaded(right.data));
      },
    );
  }
 Future<void> createAddress(AddressParams params) async {
    emit(CreateAddressLoading());

    final result = await createAdressesUseCase.call(params);
    result.fold(
      (failure) => emit(CreateAddressError(
        failure.message,
      )),
      (right) => emit(CreateAddressLoaded(right)),
    );
  }
  Future<void> createOrder(OrderParams params,String addressId) async {
    emit(CreateOrderLoading());

    final result = await createOrderUseCase.call(params,addressId);
    result.fold(
      (failure) => emit(CreateOrderError(
        failure.message,
      )),
      (right) => emit(CreateOrderLoaded(right)),
    );
  }
}
