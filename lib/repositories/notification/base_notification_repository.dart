import 'package:bloc_chat/models/models.dart';

abstract class BaseNotificationRepository {
  Stream<List<Future<Notif>>> getUserNotifications({String userId});
}
