import 'package:bloc_chat/data/models/user.dart';
import 'package:bloc_chat/logic/cubit/cubit/firebase_cubit.dart';
import 'package:flutter/material.dart';

import 'package:bloc_chat/presentation/screens/chat_screen.dart';
import 'package:bloc_chat/presentation/screens/lobby_screen.dart';
import 'package:bloc_chat/presentation/screens/login_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => LobbyScreen(
                // title: 'Innloggingsskjerm',
                // color: Colors.lightBlueAccent,
                ));
        break;
      case '/lobby':
        return MaterialPageRoute(
            builder: (_) => LobbyScreen(
                // title: 'Lobby',
                // color: Colors.redAccent,
                ));
        break;
      case '/chat':
        return MaterialPageRoute(
            builder: (_) => ChatScreen(
                  user: User(
                    name: 'Runar Byre',
                    urlAvatar:
                        'https://media-exp1.licdn.com/dms/image/C5635AQHynhL1EodFTA/profile-framedphoto-shrink_400_400/0/1615913791556?e=1616684400&v=beta&t=bDeuXYGHvca2N7gK8CWvSt5XWxnoZDApnkXuP6Q6Phc',
                    lastMessageTime: DateTime.now(),
                  ),
                  // title: 'Chat',
                  // color: Colors.greenAccent,
                ));
        break;
      default:
        return null;
    }
  }
}
