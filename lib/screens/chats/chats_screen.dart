import 'package:bloc_chat/blocs/blocs.dart';
import 'package:bloc_chat/constants/constants.dart';
import 'package:bloc_chat/screens/chats/cubit/chats_cubit.dart';
import 'package:bloc_chat/screens/chats/cubit/sendMessage_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

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
                    List<MessageBubble> messageBubbles = [];
                    if (snapshot.hasData) {
                      final smessages = snapshot.data.docs.reversed;

                      for (var smessage in smessages) {
                        final messageData = smessage.data();
                        final messageText = messageData['text'];
                        final messageSender = messageData['sender'];
                        final messageTime = messageData['createdAt'];
                        final messageWidget = Text(
                          '$messageTime skrev $messageSender $messageText',
                          style: TextStyle(fontSize: 24),
                        );
                        messageWidgets.add(messageWidget);

                        final messageBubble = MessageBubble(
                          sender: messageSender,
                          text: messageText,
                          isMe: context.read<AuthBloc>().state.user.email ==
                              messageSender,
                        );

                        messageBubbles.add(messageBubble);
                      }
                    }

                    return Expanded(
                      child: ListView(
                        reverse: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        children: messageBubbles,
                        // children: messageWidgets,
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
          //   Form(
          //     key: _formKey,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         const SizedBox(height: 10),
          //         BlocConsumer<SendMessageCubit, SendMessageState>(
          //           listener: (context, state) {
          //             // TODO: implement listener
          //           },
          //           builder: (context, state) {
          //             return Row(
          //               children: [
          //                 const Text(
          //                   '',
          //                   style: TextStyle(
          //                     fontSize: 28.0,
          //                     fontWeight: FontWeight.bold,
          //                     color: Colors.orange,
          //                   ),
          //                   textAlign: TextAlign.center,
          //                 ),
          //                 const SizedBox(width: 2.0),
          //                 Flexible(
          //                   child:
          //                       BlocConsumer<SendMessageCubit, SendMessageState>(
          //                     listener: (context, state) {
          //                       // TODO: implement listener
          //                     },
          //                     builder: (context, state) {
          //                       return TextFormField(
          //                         // controller: messageController,
          //                         validator: (value) {
          //                           if (value.isEmpty) {
          //                             return 'Skriv inn en melding';
          //                           }
          //                           return null;
          //                         },
          //                         style: TextStyle(color: Colors.white),
          //                         decoration: InputDecoration(
          //                           filled: true,
          //                           fillColor: Colors.orange,
          //                           hintText: 'Aa',
          //                           hintStyle: TextStyle(
          //                             color: Colors.white,
          //                             backgroundColor: Colors.orange,
          //                           ),
          //                         ),
          //                       );
          //                     },
          //                   ),
          //                 ),
          //                 IconButton(
          //                   icon: Icon(Icons.send),
          //                   color: Colors.orange,
          //                   hoverColor: Colors.orange[600],
          //                   iconSize: 48,
          //                   onPressed: () => _submitForm(
          //                     context,
          //                     state.status == SendMessageStatus.submitting,
          //                   ),
          //                 ),
          //               ],
          //             );
          //           },
          //         ),
          //       ],
          //     ),
          //   ),

          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                      decoration: kMessageTextFieldDecoration,
                      controller: messageController),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  color: Colors.orange,
                  hoverColor: Colors.orange[600],
                  iconSize: 28,
                  onPressed: () {
                    context.read<SendMessageCubit>().addNewMessage(
                          messageController.text,
                          context.read<AuthBloc>().state.user.email,
                          DateFormat.yMEd()
                              .add_jms()
                              .format(DateTime.now().toLocal()),
                        );
                    messageController.clear();
                  },
                )
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

  // void _submitForm(BuildContext context, bool isSubmitting) {
  //   if (_formKey.currentState.validate() && !isSubmitting) {
  //     context.read<SendMessageCubit>().sendMessageWithCredentials();
  //     // }
  //   }
  // void _submitForm(BuildContext context, bool isSubmitting) {
  //   if (_formKey.currentState.validate() && !isSubmitting) {
  //     context.read<MessagesBloc>().submitMessage();
  //   }
  // }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
