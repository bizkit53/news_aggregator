import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final List<String> savedUrls;
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.savedUrls,
  });

  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>?;

    return User(
      id: userDoc.id,
      name: userData!['name'],
      email: userData['email'],
      savedUrls: userData['savedUrls'],
    );
  }

  factory User.initial() {
    return const User(
      id: '',
      name: '',
      email: '',
      savedUrls: [''],
    );
  }

  @override
  List<Object> get props => [id, name, email, savedUrls];

  @override
  bool get stringify => true;
}
