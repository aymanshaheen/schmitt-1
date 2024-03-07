part of 'package_cubit.dart';
abstract class PackageStates extends Equatable {
  const PackageStates();

  @override
  List<Object> get props => [];
}

class PackageInitial extends PackageStates {}

class PackageLoading extends PackageStates {}

class PackageSuccess extends PackageStates {
  final List<Package> packages;

  const PackageSuccess(this.packages);
}

class PackageFailure extends PackageStates {
  final String errMessage;

  const PackageFailure(this.errMessage);
}