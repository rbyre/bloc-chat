import 'dart:async';

import 'package:bloc_chat/models/models.dart';
import 'package:bloc_chat/repositories/firebase/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsCubit extends Cubit {
  final _firebaseService = FirebaseService();

  // initialize with empty list
  ChatsCubit() : super([]);

  // void getMessages() async => emit(await _firebaseService.getMessages());
  void messageStream() async => emit(await _firebaseService.messageStream());
  // Future addNewMessage() async => emit(await _firebaseService.addNewMessage());
}

abstract class MessagesEvent {}

class LoadMessagesEvent extends MessagesEvent {}

class AddNewMessageEvent extends MessagesEvent {}

abstract class MessagesState {}

class LoadingMessagesState extends MessagesState {}

class LoadedMessagesState extends MessagesState {
  Stream messages;
  LoadedMessagesState({this.messages});
}

class AddNewMessageState extends MessagesState {}

// class SavingMessagesState extends MessagesState {}

// class SavedMessagesState extends MessagesState {
//   Stream messages;
//   SavedMessagesState({this.messages});
// }

class FailedToLoadMessagesState extends MessagesState {
  Error error;
  FailedToLoadMessagesState({this.error});
}

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final _firebaseService = FirebaseService();
  StreamSubscription _messagesSubscription;

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
      // } else if (event is AddNewMessageEvent) {
      //   yield* _mapAddMessageToState(event);
      // }
    }

    // Stream<MessagesState> _mapAddMessageToState(AddNewMessageEvent event) async* {
    //   _firebaseService.addNewMessage(event.message);
    // }

    @override
    Future<void> close() {
      _messagesSubscription?.cancel();
      return super.close();
    }
  }
}
