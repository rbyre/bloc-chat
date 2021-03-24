import 'package:bloc_chat/data/models/user.dart';
import 'package:bloc_chat/logic/cubit/cubit/firebase_cubit.dart';
import 'package:bloc_chat/presentation/widgets/chat_body_widgets.dart';
import 'package:bloc_chat/presentation/widgets/chat_header_widget.dart';
import 'package:flutter/material.dart';

class LobbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: StreamBuilder<List<User>>(
            stream: FirebaseCubit.getUsers(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text('Noe gikk galt');
                  } else {
                    final users = snapshot.data;

                    if (users.isEmpty) {
                      return Text('Ingen brukere funnet');
                    } else
                      return Column(
                        children: [
                          ChatHeaderWidget(users: users),
                          ChatBodyWidget(users: users)
                        ],
                      );
                  }
              }
            },
          ),
        ),
      );
}
