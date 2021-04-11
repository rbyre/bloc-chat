part of 'edit_profile_cubit.dart';

enum EditProfileStatus { initial, submitting, success, error }

class EditProfileState extends Equatable {
  final File profileImage;
  final String username;
  final EditProfileStatus status;
  final Failure failure;

  const EditProfileState({
    @required this.profileImage,
    @required this.username,
    @required this.status,
    @required this.failure,
  });

  factory EditProfileState.initial() {
    return const EditProfileState(
      profileImage: null,
      username: '',
      status: EditProfileStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object> get props => [
        profileImage,
        username,
        status,
        failure,
      ];

  EditProfileState copyWith({
    File profileImage,
    String username,
    EditProfileStatus status,
    Failure failure,
  }) {
    return EditProfileState(
      profileImage: profileImage ?? this.profileImage,
      username: username ?? this.username,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
