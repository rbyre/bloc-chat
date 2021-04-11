import 'package:bloc_chat/models/models.dart';
import 'package:bloc_chat/repositories/firebase/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LobbyCubit extends Cubit<List<User>> {
  final _firebaseService = FirebaseService();

  // initialize with empty list
  LobbyCubit() : super([]);

  void getUsers() async => emit(await _firebaseService.getUsers());

  void getStreamedUsers() async => emit(await _firebaseService.userStream());
}
