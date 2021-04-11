import 'dart:async';
import 'package:bloc_chat/blocs/blocs.dart';
import 'package:bloc_chat/repositories/repositories.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:bloc_chat/models/models.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  final AuthBloc _authBloc;
  ProfileBloc(
      {@required UserRepository userRepository, @required AuthBloc authBloc})
      : _userRepository = userRepository,
        _authBloc = authBloc,
        super(ProfileState.initial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileLoadUser) {
      yield* _mapProfileLoadUserToState(event);
    }
  }

  Stream<ProfileState> _mapProfileLoadUserToState(
    ProfileLoadUser event,
  ) async* {
    yield state.copyWith(status: ProfileStatus.loading);
    try {
      final user = await _userRepository.getUserWithId(userId: event.userId);
      final isCurrentUser = _authBloc.state.user.uid == event.userId;

      yield state.copyWith(
        user: user,
        isCurrentUser: isCurrentUser,
        status: ProfileStatus.loaded,
      );
    } catch (err) {
      yield state.copyWith(
          status: ProfileStatus.error,
          failure: const Failure(
              message: 'Vi kunne ikke laste inn denne profilen.'));
    }
  }
}
