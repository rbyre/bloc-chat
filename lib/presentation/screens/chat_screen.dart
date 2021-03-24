import 'package:bloc_chat/data/models/user.dart';
import 'package:bloc_chat/presentation/widgets/messages_widget.dart';
import 'package:bloc_chat/presentation/widgets/new_message_widget.dart';
import 'package:bloc_chat/presentation/widgets/profile_header.widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  const ChatScreen({
    @required this.user,
    Key key,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(name: widget.user.name),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: MessagesWidget(idUser: widget.user.idUser),
                ),
              ),
              NewMessageWidget(idUser: widget.user.idUser)
            ],
          ),
        ),
      );
}
