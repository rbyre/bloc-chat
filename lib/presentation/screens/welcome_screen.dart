import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
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
    return Scaffold(
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
                        TypewriterAnimatedText(' chat'),
                      ],
                      totalRepeatCount: 4,
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            NiceButton(
              text: 'Logg Inn',
              background: Colors.orange[500],
              elevation: 8.0,
              radius: 52.0,
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
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
                Navigator.of(context).pushNamed('/registration');
              },
            ),
          ],
        ),
      ),
    );
  }
}
