import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String sender;
  final String text;
  final DateTime createdAt;

  const MessageEntity(
    this.id,
    this.sender,
    this.text,
    this.createdAt,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender,
      'text': text,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory MessageEntity.fromMap(Map<String, dynamic> map) {
    return MessageEntity(
      map['id'],
      map['sender'],
      map['text'],
      DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageEntity.fromJson(String source) =>
      MessageEntity.fromMap(json.decode(source));

  MessageEntity copyWith({
    String id,
    String sender,
    String text,
    DateTime createdAt,
  }) {
    return MessageEntity(
      id ?? this.id,
      sender ?? this.sender,
      text ?? this.text,
      createdAt ?? this.createdAt,
    );
  }

  static MessageEntity fromSnapshot(DocumentSnapshot snap) {
    return MessageEntity(
      snap.data()['text'],
      snap.id,
      snap.data()['sender'],
      snap.data()['createdAt'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "message": text,
      "sender": sender,
      "createdAt": createdAt,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, sender, text, createdAt];
}
