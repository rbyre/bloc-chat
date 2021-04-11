part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  final User user;
  final bool isCurrentUser;
  final ProfileStatus status;
  final Failure failure;

  const ProfileState({
    @required this.user,
    @required this.isCurrentUser,
    @required this.status,
    @required this.failure,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      user: User.empty,
      isCurrentUser: false,
      status: ProfileStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object> get props => [user, isCurrentUser, status, failure];

  ProfileState copyWith({
    User user,
    bool isCurrentUser,
    ProfileStatus status,
    Failure failure,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
