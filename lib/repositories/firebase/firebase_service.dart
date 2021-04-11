import 'package:bloc_chat/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<List<User>> getUsers() async {
    final users = await _userCollection.get();
    List<User> allUsers = [];
    for (var user in users.docs) {
      var userToAdd = User.fromDocument(user);
      allUsers.add(userToAdd);
    }
    return allUsers;
  }
}
