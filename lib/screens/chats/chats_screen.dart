import 'package:bloc_chat/models/models.dart';
import 'package:bloc_chat/screens/chats/cubit/chats_cubit.dart';
import 'package:bloc_chat/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_button/NiceButton.dart';

class ChatsScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chat'),
      ),
      body: Column(
        children: [
          BlocBuilder<MessagesBloc, MessagesState>(builder: (context, state) {
            if (state is LoadingMessagesState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedMessagesState) {
              return StreamBuilder<QuerySnapshot>(
                  stream: state.messages,
                  builder: (context, snapshot) {
                    List<Text> messageWidgets = [];
                    if (snapshot.hasData) {
                      final smessages = snapshot.data.docs;

                      for (var smessage in smessages) {
                        final messageData = smessage.data();
                        final messageText = messageData['text'];
                        final messageSender = messageData['sender'];
                        final messageWidget = Text(
                          '$messageSender said $messageText',
                          style: TextStyle(fontSize: 24),
                        );
                        messageWidgets.add(messageWidget);
                      }
                    }

                    return Expanded(
                      child: ListView(
                        children: messageWidgets,
                      ),
                    );
                  });
            } else {
              return Container();
            }
          }),
          const SizedBox(
            height: 12,
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      '',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(width: 2.0),
                    Flexible(
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.orange,
                          hintText: 'Aa',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            backgroundColor: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      color: Colors.orange,
                      hoverColor: Colors.orange[600],
                      iconSize: 48,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // return Card(
    //   child: ListTile(
    //     title: Row(
    //       children: [
    //         // UserProfileImage(
    //         //   radius: 20.0,
    //         //   profileImageUrl: allUsers[index].profileImageUrl,
    //         // ),
    //         const SizedBox(
    //           width: 10,
    //         ),
    //         Text(state.messages[index].text),
    //       ],
    //     ),
    //   ),
    //         ),
    //       },
    //     );
    //   } else if (state is FailedToLoadMessagesState) {
    //     return Center(
    //       child: Text('En feil har skjedd ${state.error}'),
    //     );
//            } else {
//             return Container();
//         }
//        },
//       ),
//     );
//   }
// }
  }
}
