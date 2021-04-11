import 'package:bloc_chat/models/models.dart';
import 'package:bloc_chat/repositories/firebase/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsCubit extends Cubit {
  final _firebaseService = FirebaseService();

  // initialize with empty list
  ChatsCubit() : super([]);

  // void getMessages() async => emit(await _firebaseService.getMessages());
  void messageStream() async => emit(await _firebaseService.messageStream());
}

abstract class MessagesEvent {}

class LoadMessagesEvent extends MessagesEvent {}

abstract class MessagesState {}

class LoadingMessagesState extends MessagesState {}

class LoadedMessagesState extends MessagesState {
  Stream messages;
  LoadedMessagesState({this.messages});
}

class FailedToLoadMessagesState extends MessagesState {
  Error error;
  FailedToLoadMessagesState({this.error});
}

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final _firebaseService = FirebaseService();
  MessagesBloc() : super(LoadingMessagesState());

  @override
  Stream<MessagesState> mapEventToState(MessagesEvent event) async* {
    if (event is LoadMessagesEvent) {
      yield LoadingMessagesState();

      try {
        final messages = await _firebaseService.messageStream();
        yield LoadedMessagesState(messages: messages);
      } catch (e) {
        yield FailedToLoadMessagesState(error: e);
      }
    }
  }
}
