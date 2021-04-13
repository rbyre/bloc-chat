part of 'sendMessage_cubit.dart';

enum SendMessageStatus { initial, submitting, success, error }

class SendMessageState extends Equatable {
  final String text;
  final SendMessageStatus status;
  final Failure failure;

  const SendMessageState({
    @required this.text,
    @required this.status,
    @required this.failure,
  });

  factory SendMessageState.initial() {
    return SendMessageState(
      text: '',
      status: SendMessageStatus.initial,
      failure: const Failure(),
    );
  }

  bool get isFormValid => text.isNotEmpty;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [text, status, failure];

  SendMessageState copyWith({
    String text,
    SendMessageStatus status,
    Failure failure,
  }) {
    return SendMessageState(
      text: text ?? this.text,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
