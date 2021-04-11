import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuthRepository {
  // this user getter is a listener that constant listen to our firebase authentication
  Stream<auth.User> get user;
  Future<auth.User> signUpWithEmailAndPassword({
    String username,
    String email,
    String password,
  });
  Future<auth.User> logInWithEmailAndPassword({
    String email,
    String password,
  });
  Future<void> logOut();
}
