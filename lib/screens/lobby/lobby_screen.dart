import 'package:bloc_chat/blocs/blocs.dart';
import 'package:bloc_chat/models/models.dart';
import 'package:bloc_chat/screens/lobby/cubit/lobby_cubit.dart';
import 'package:bloc_chat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LobbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LobbyCubit, List<User>>(builder: (context, allUsers) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Velkommen ${context.read<AuthBloc>().state.user.email}'),
          actions: [
            // UserProfileImage(
            //   radius: 20.0,
            //   profileImageUrl:
            //       user.profileImageUrl,
            // ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
              },
            )
          ],
        ),
        body: allUsers.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
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
                          const SizedBox(width: 10),
                          Text(allUsers[index].email),
                        ],
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
