import 'package:bloc_chat/models/models.dart';
import 'package:bloc_chat/repositories/firebase/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'sendMessage_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final _firebaseService = FirebaseService();
  // SendMessageCubit() : super(null);
  SendMessageCubit() : super(SendMessageState.initial());

  void messageChanged(String value) {
    emit(state.copyWith(text: value, status: SendMessageStatus.initial));
  }

  addNewMessage(String value, String sender, String createdAt) async {
    emit(await _firebaseService.addNewMessage(value, sender, createdAt));
    print(value);
  }

  void inputChanged(String value) {
    emit(state.copyWith(
      text: value,
    ));
  }

  // void sendMessageWithCredentials() async {
  //   print(state);
  //   if (state.isFormValid || state.status == SendMessageStatus.initial) return;
  //   emit(state.copyWith(status: SendMessageStatus.submitting));
  //   try {
  //     await _firebaseService.addNewMessage(state.text);
  //     print('hallo');
  //     emit(state.copyWith(status: SendMessageStatus.success));
  //   } on Failure catch (err) {
  //     emit(state.copyWith(failure: err, status: SendMessageStatus.error));
  //   }
  // }
}
