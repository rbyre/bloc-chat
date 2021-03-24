part of 'firebase_cubit.dart';

class FirebaseState extends Equatable {
  // const FirebaseState();
  String chatState;
  FirebaseState({
    @required this.chatState,
  });

  @override
  List<Object> get props => [this.chatState];
}

// class FirebaseInitial extends FirebaseState {}
