import 'package:bloc_chat/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';

class ProfileButton extends StatelessWidget {
  final bool isCurrentUser;
  const ProfileButton({
    Key key,
    @required this.isCurrentUser,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return isCurrentUser
        ? NiceButton(
            text: 'Editer Profil',
            elevation: 8.0,
            radius: 52.0,
            background: Colors.orange,
            onPressed: () => Navigator.of(context).pushNamed(
              EditProfileScreen.routeName,
              arguments: EditProfileScreenArgs(context: context),
            ),
          )
        : NiceButton(
            text: 'Annen bruker',
            elevation: 8.0,
            radius: 52.0,
            background: Colors.orange[50],
            onPressed: () {},
          );
  }
}
