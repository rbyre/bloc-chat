import 'package:bloc_chat/models/models.dart';
import 'package:bloc_chat/screens/chats/cubit/chats_cubit.dart';
import 'package:bloc_chat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatsCubit, List<User>>(
        builder: (context, allUsers) {
          if (allUsers.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: allUsers.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Row(
                    children: [
                      UserProfileImage(
                        radius: 20.0,
                        profileImageUrl: allUsers[index].profileImageUrl,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(allUsers[index].email),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
