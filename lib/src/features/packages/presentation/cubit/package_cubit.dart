//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// part 'package_states.dart';
// class PackageCubit extends Cubit<PackageStates> {
//   PackageCubit(this.packageRepository) : super(PackageInitial());
//
//   final PackageRepository packageRepository;
//   Future<void> fetchPackages() async {
//     emit(PackageLoading());
//     var result = await packageRepository.getPackages();
//     result.fold((failure) {
//       emit(PackageFailure(failure.message));
//     }, (packages) {
//       emit( PackageSuccess(packages));
//     });
//   }
// }