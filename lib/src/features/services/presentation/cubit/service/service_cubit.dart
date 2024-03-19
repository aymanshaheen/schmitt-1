import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/entities/meta.dart';
import 'package:schmitt/src/core/usecase/address_params.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/features/services/domain/entities/adresses.dart';
import 'package:schmitt/src/features/services/domain/entities/car.dart';
import 'package:schmitt/src/features/services/domain/entities/color.dart';
import 'package:schmitt/src/features/services/domain/entities/company.dart';
import 'package:schmitt/src/features/services/domain/entities/review.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';
import 'package:schmitt/src/features/services/domain/usercases/add_review.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_adress.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_car.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_order_use_case.dart';
import 'package:schmitt/src/features/services/domain/usercases/delete_address.dart';
import 'package:schmitt/src/features/services/domain/usercases/delete_car.dart';
import 'package:schmitt/src/features/services/domain/usercases/get_adresses.dart';
import 'package:schmitt/src/features/services/domain/usercases/get_cars.dart';
import 'package:schmitt/src/features/services/domain/usercases/get_colors.dart';
import 'package:schmitt/src/features/services/domain/usercases/get_companies.dart';
import 'package:schmitt/src/features/services/domain/usercases/get_reviews.dart';
import 'package:schmitt/src/features/services/domain/usercases/show_car.dart';
import 'package:schmitt/src/features/services/domain/usercases/show_service_use_case.dart';
import 'package:schmitt/src/features/services/domain/usercases/update_address.dart';
import 'package:schmitt/src/features/services/domain/usercases/update_car.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_state.dart';

class ServiceCubit extends Cubit<ServiceStates> {
  final AddReviweUseCase addReviweUseCase;
  final GetReviwesUseCase getReviwesUseCase;
  final ShowServicesUseCase getServicesUseCase;
  final CreateOrderUseCase createOrderUseCase;
  final GetAdressesUseCase getAdressesUseCase;
  final UpdateAddressUseCase updateAddressUseCase;
  final DeleteAddressUseCase deleteAddressUseCase;
  final CreateAdressesUseCase createAdressesUseCase;
  final GetCarsUseCase getCarsUseCase;
  final ShowCarUseCase showCarUseCase;
  final CreateCarUseCase createCarUseCase;
  final UpdateCarUseCase updateCarUseCase;
  final DeleteCarUseCase deleteCarUseCase;
  final GetColorsUseCase getColorsUseCase;
  final GetCompaniesUseCase getCompaniesUseCase;
  ServiceCubit(
      {required this.addReviweUseCase,
      required this.createAdressesUseCase,
      required this.getColorsUseCase,
      required this.deleteAddressUseCase,
      required this.updateAddressUseCase,
      required this.updateCarUseCase,
      required this.showCarUseCase,
      required this.getCompaniesUseCase,
      required this.deleteCarUseCase,
      required this.createOrderUseCase,
      required this.createCarUseCase,
      required this.getCarsUseCase,
      required this.getAdressesUseCase,
      required this.getServicesUseCase,
      required this.getReviwesUseCase})
      : super(ServiceInitial());
  static ServiceCubit get(context) => BlocProvider.of(context);
  int tabbedOffer = 0;
  int? selectedAddressIndex;

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
  int numberOfChilds = 0;
  int carWashPrice = 30;
  void decrementRoomCount(int index) {
    if (roomsCount[index] == 0) {
      return;
    }

    roomsCount[index]--;
    calculateTotalPrice();
    emit(RoomCountUpdated());
  }

  void clearData() {
    tabbedOffer = 0;
    selectedAddressIndex = null;
    roomsCount = [0, 0, 0, 0, 0];
    numberOfChilds = 0;
    currentStep = 1;
    selectedDate = DateTime.now().add(const Duration(days: 0));
    selectedIndex = 0;
    selectedHour = null;
  }

  void incrementRoomCount(int index) {
    roomsCount[index]++;
    calculateTotalPrice();
    emit(RoomCountUpdated());
  }

  void incrementChilds(int index) {
    numberOfChilds++;
    emit(RoomCountUpdated());
  }

  void decrementRoomChild(int index) {
    if (numberOfChilds == 0) {
      return;
    }

    numberOfChilds--;
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
  int selectedIndex = 0;

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

  Service? service;
  Future<void> getServices(int page, String id) async {
    emit(ServicesLoading());

    final result = await getServicesUseCase.call(page, id);
    result.fold(
      (failure) => emit(ServicesError(
        message: failure.message,
      )),
      (right) {
        service = right.data;
        emit(ServiceLoaded(right.data));
      },
    );
  }

  void selectAddressIndex(int index) {
    selectedAddressIndex = index;
    AppConstants.addressId = addresses![index].id;
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

  double getAverageRating() {
    if (reviews == null || reviews!.isEmpty) {
      return 0.0;
    }
    double total = 0.0;
    for (var review in reviews!) {
      total += review.rating!;
    }
    return total / reviews!.length;
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

  List<Address>? addresses = [];
  Meta? metaAddresses;
  Future<void> getAdresses(int page) async {
    if (page == 1) {
      emit(GetAddressesLoading());
    }

    final result = await getAdressesUseCase.call(page);
    result.fold(
      (failure) => emit(GetAddressesError(
        failure.message,
      )),
      (right) {
        addresses!.addAll(right.data!);
        metaAddresses = right.meta;
        emit(GetAddressesLoaded(right.data));
      },
    );
  }

  Address? address;
  Future<void> createAddress(AddressParams params) async {
    emit(CreateAddressLoading());

    final result = await createAdressesUseCase.call(params);
    result.fold(
      (failure) => emit(CreateAddressError(
        failure.message,
      )),
      (right) {
        address = right.data;
        emit(CreateAddressLoaded(right.data!));
      },
    );
  }

  Future<void> createOrder(OrderParams params, String addressId) async {
    emit(CreateOrderLoading());

    final result = await createOrderUseCase.call(params, addressId);
    result.fold(
      (failure) => emit(CreateOrderError(
        failure.message,
      )),
      (right) => emit(CreateOrderLoaded(right)),
    );
  }

  List<CarDataEntity>? cars = [];
  Meta? metaCars;

  Future<void> getCars(int page) async {
    emit(GetCarsLoading());

    final result = await getCarsUseCase.call(page);
    result.fold(
        (failure) => emit(GetCarsError(
              failure.message,
            )), (right) {
      cars!.addAll(right.data!);
      metaCars = right.meta;
      emit(GetCarsLoaded(right.data));
    });
  }

  CarDataEntity? car;
  Future<void> showCar(int id) async {
    emit(ShowCarLoading());

    final result = await showCarUseCase.call(id);
    result.fold(
        (failure) => emit(ShowCarError(
              failure.message,
            )), (right) {
      car = right.data;
      emit(ShowCarLoaded(right.data));
    });
  }

  Future<void> createCar(CarParams params) async {
    emit(CreateCarLoading());

    final result = await createCarUseCase.call(params);
    result.fold(
      (failure) => emit(CreateCarError(
        failure.message,
      )),
      (right) => emit(CreateCarLoaded()),
    );
  }

  Future<void> updateCar(CarParams params, int id) async {
    emit(CreateCarLoading());

    final result = await updateCarUseCase.call(params, id);
    result.fold(
      (failure) => emit(CreateCarError(
        failure.message,
      )),
      (right) => emit(CreateCarLoaded()),
    );
  }

  Future<void> deleteCar(int id) async {
    emit(DeleteCarLoading());

    final result = await deleteCarUseCase.call(id);
    result.fold(
      (failure) => emit(DeleteCarError(
        failure.message,
      )),
      (right) => emit(DeleteCarLoaded()),
    );
  }

  Future<void> updateAddress(AddressParams params, int id) async {
    emit(CreateCarLoading());

    final result = await updateAddressUseCase.call(params, id);
    result.fold(
      (failure) => emit(CreateCarError(
        failure.message,
      )),
      (right) => emit(CreateCarLoaded()),
    );
  }

  Future<void> deleteAddress(int id) async {
    emit(DeleteCarLoading());

    final result = await deleteAddressUseCase.call(id);
    result.fold(
      (failure) => emit(DeleteCarError(
        failure.message,
      )),
      (right) => emit(DeleteCarLoaded()),
    );
  }

  List<Company>? companies = [];
  Future<void> getCompanies(int page, String addressId) async {
    emit(GetCompaniesLoading());

    final result = await getCompaniesUseCase.call(page, addressId);
    result.fold(
        (failure) => emit(GetCompaniesError(
              failure.message,
            )), (right) {
      companies = right.data;
      emit(GetCompaniesLoaded(right.data));
    });
  }

  List<ColorData>? colors = [];
  Future<void> getColors(String addressId) async {
    emit(GetColorsLoading());

    final result = await getColorsUseCase.call(addressId);
    result.fold(
        (failure) => emit(GetColorsError(
              failure.message,
            )), (right) {
      colors = right.data;
      emit(GetColorsLoaded(right.data));
    });
  }
}
