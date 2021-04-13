// import 'package:bloc_chat/models/models.dart';
// import 'package:flutter/material.dart';
// import 'package:bloc_chat/utils.dart';

// class MessageField {
//   static final String createdAt = 'createdAt';
// }

// class Message {
//   final String idUser;
//   final String urlAvatar;
//   final String username;
//   final String message;
//   final DateTime createdAt;

//   const Message({
//     @required this.idUser,
//     @required this.urlAvatar,
//     @required this.username,
//     @required this.message,
//     @required this.createdAt,
//   });

//   static Future<Message> fromDocument(DocumentSnapshot doc) async {
//     if (doc == null) return null;
//     final data = doc.data();
//     final senderRef = data['sender'] as DocumentReference;
//     if (senderRef != null) {
//       final senderDoc = await senderRef.get();
//       if (senderDoc.exists) {
//         return Message(
//           idUser: doc.IdUser,
//           urlAvatar: doc.urlAvatar,
//           username: User.fromDocument(senderDoc),
//           message: data['message'] ?? '',
//           createdAt: (data['createdAt'] as Timestamp)?.toDate(),
//         );
//       }
//     }
//     return null;
//   }

//   static Message fromJson(Map<String, dynamic> json) => Message(
//         idUser: json['idUser'],
//         urlAvatar: json['urlAvatar'],
//         username: json['username'],
//         message: json['message'],
//         createdAt: Utils.toDateTime(json['createdAt']),
//       );

//   Map<String, dynamic> toJson() => {
//         'idUser': idUser,
//         'urlAvatar': urlAvatar,
//         'username': username,
//         'message': message,
//         'createdAt': Utils.fromDateTimeToJson(createdAt),
//       };
// }

import 'package:bloc_chat/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_chat/config/paths.dart';
import 'package:meta/meta.dart';

import 'package:bloc_chat/models/models.dart';

class Message extends Equatable {
  final String id;
  final String sender;
  final String text;
  final DateTime createdAt;

  const Message({
    this.id,
    @required this.sender,
    @required this.text,
    this.createdAt,
  });

  @override
  List<Object> get props => [id, sender, text, createdAt];

  Message copyWith({
    String id,
    String sender,
    String text,
    DateTime createdAt,
  }) {
    return Message(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'sender': sender,
      'text': text,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  static Future<Message> fromDocument(DocumentSnapshot doc) async {
    if (doc == null) return null;
    final data = doc.data();
    final senderRef = data['sender'] as DocumentReference;
    if (senderRef != null) {
      final senderDoc = await senderRef.get();
      if (senderDoc.exists) {
        return Message(
          id: doc.id,
          sender: data['sender'],
          text: data['text'] ?? '',
          createdAt: (data['createdAt'] as Timestamp)?.toDate(),
        );
      }
    }
    return null;
  }
}
