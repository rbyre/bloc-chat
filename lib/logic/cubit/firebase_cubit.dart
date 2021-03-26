import 'package:bloc/bloc.dart';
import 'package:bloc_chat/data/models/message.dart';
import 'package:bloc_chat/data/models/user.dart';
import 'package:bloc_chat/presentation/widgets/data.dart';
import 'package:bloc_chat/utils.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'firebase_state.dart';

class FirebaseCubit extends Cubit<FirebaseState> {
  FirebaseCubit() : super(FirebaseState(chatState: ""));

  // final _auth = FirebaseAuth.instance;

  // addData() {
  //   Map<String, dynamic> demoData = {
  //     "name": "Runar Byre",
  //     "motto": "firebase is great"
  //   };

  //   CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  //   chats.add(demoData);
  // }

  static Stream<List<User>> getUsers() => FirebaseFirestore.instance
      .collection('users')
      .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(User.fromJson));

  static Future uploadMessage(String idUser, String message) async {
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$idUser/messages');

    final newMessage = Message(
      idUser: myId,
      urlAvatar: myUrlAvatar,
      username: myUsername,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('users');
    await refUsers
        .doc(idUser)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getMessages(String idUser) =>
      FirebaseFirestore.instance
          .collection('chats/$idUser/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Future addRandomUsers(List<User> users) async {
    final refUsers = FirebaseFirestore.instance.collection('users');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(idUser: userDoc.id);

        await userDoc.set(newUser.toJson());
      }
    }
  }

//  void getCurrentUser() {
//    final user = await  _auth.authStateChanges()
//   .listen((User user) {
//     if (user == null) {
//       print('User is currently signed out!');
//     } else {
//       print('User is signed in!');
//     }
//   });
}
