import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String profileImageUrl;

  const User({
    @required this.id,
    @required this.username,
    @required this.email,
    @required this.profileImageUrl,
  });

  static const empty = User(
    id: '',
    username: '',
    email: '',
    profileImageUrl: '',
  );

  @override
  List<Object> get props => [id, username, email, profileImageUrl];

  User copyWith({
    String id,
    String username,
    String email,
    String profileImageUrl,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'username': username,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    if (doc == null) return null;
    final data = doc.data();
    return User(
      id: doc.id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
    );
  }
}
