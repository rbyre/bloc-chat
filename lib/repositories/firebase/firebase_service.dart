import 'package:bloc_chat/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  CollectionReference _messageCollection =
      FirebaseFirestore.instance.collection('messages');

  Future<List<User>> getUsers() async {
    final users = await _userCollection.get();
    List<User> allUsers = [];
    for (var user in users.docs) {
      var userToAdd = User.fromDocument(user);
      allUsers.add(userToAdd);
    }
    return allUsers;
  }

  // messageStream() async {
  //   await for (var snapshot in _messageCollection.snapshots()) {
  //     for (var message in snapshot.docs) {
  //       return message.data;
  //     }
  //   }
  // }

  messageStream() async => _messageCollection.snapshots();

  userStream() async => _userCollection.snapshots();

  getCurrentUser() async {}
}
