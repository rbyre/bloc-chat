import 'package:bloc_chat/blocs/blocs.dart';
import 'package:bloc_chat/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => WelcomeScreen(),
    );
  }

  // static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey[800], end: Colors.black)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.unauthenticated) {
            // Go to the Login Screen.
            Navigator.of(context).pushNamed(LoginScreen.routeName);
          } else if (state.status == AuthStatus.authenticated) {
            // Go to the Nav Screen.
            Navigator.of(context).pushNamed(NavScreen.routeName);
          }
        },
        child: Scaffold(
          backgroundColor: animation.value,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Hero(
                      tag: 'naeva',
                      child: Container(
                        child: Image.asset('images/naeva.png'),
                        height: 60.0,
                      ),
                    ),
                    SizedBox(
                      width: 250.0,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(' chat',
                                speed: Duration(milliseconds: 500)),
                          ],
                          totalRepeatCount: 4,
                          onTap: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 48.0,
                ),
                NiceButton(
                  text: 'Logg Inn',
                  background: Colors.orange[500],
                  elevation: 8.0,
                  radius: 52.0,
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                NiceButton(
                  text: 'Registrer',
                  elevation: 8.0,
                  radius: 52.0,
                  background: Colors.orange[500],
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignupScreen.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
