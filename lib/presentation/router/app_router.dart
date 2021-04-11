import 'package:bloc_chat/data/models/user.dart';
// import 'package:bloc_chat/logic/cubit/cubit/firebase_cubit.dart';
import 'package:bloc_chat/screens/signup/signup_screen.dart';
import 'package:bloc_chat/screens/splash/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'package:bloc_chat/presentation/screens/chat_screen.dart';
import 'package:bloc_chat/presentation/screens/lobby_screen.dart';
import 'package:bloc_chat/screens/login/login_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
        break;
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
      case '/registration':
        return MaterialPageRoute(builder: (_) => SignupScreen());
        break;
      case '/lobby':
        return MaterialPageRoute(builder: (_) => LobbyScreen());
        break;
      case '/chat':
        return MaterialPageRoute(
            builder: (_) => ChatScreen(
                  user: User(
                    name: 'Runar Byre',
                    urlAvatar:
                        'https://runarbyre.pythonanywhere.com/static/portfolio/Runar_cropped_new.png',
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
