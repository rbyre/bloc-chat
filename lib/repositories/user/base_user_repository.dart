import 'package:bloc_chat/models/models.dart';

abstract class BaseUserRepository {
  Future<User> getUserWithId({String userId});
  Future<void> updateUser({User user});
}
