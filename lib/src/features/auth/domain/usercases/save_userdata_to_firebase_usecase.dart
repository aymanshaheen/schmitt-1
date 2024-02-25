
/*
class SaveUserDataToFirebaseUseCase
    extends BaseUseCase<void, UserEntity> {
  final UserRepository repository;

  SaveUserDataToFirebaseUseCase(this.repository);
  @override
  ResultVoid call(UserEntity parameters) async {
    return await repository.saveUserDataToFirebase(parameters);
  }
}
class UserDataParameters extends Equatable {
  final String name;
  final File? profilePic;

  const UserDataParameters({required this.name,  this.profilePic});

  @override
  List<Object?> get props => [
        name,
        profilePic,
      ];
}

*/