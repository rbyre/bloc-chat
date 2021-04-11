import 'package:bloc_chat/models/models.dart';
import 'package:bloc_chat/screens/chats/cubit/chats_cubit.dart';
import 'package:bloc_chat/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
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
                          final messageWidget =
                              Text('$messageSender said $messageText');
                          messageWidgets.add(messageWidget);
                        }
                      }

                      return Column(
                        children: messageWidgets,
                      );
                    });
              } else {
                return Container();
              }
            }),
          ],
        ));

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
