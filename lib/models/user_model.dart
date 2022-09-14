import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs
class User extends Equatable {
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
      name: userData!['name'] as String,
      email: userData['email'] as String,
      savedUrls: userData['savedUrls'] as List<String>,
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

  final String id;
  final String name;
  final String email;
  final List<String> savedUrls;

  @override
  List<Object> get props => [id, name, email, savedUrls];

  @override
  bool get stringify => true;
}
