// ignore_for_file: public_member_api_docs

part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStateChangedEvent extends AuthEvent {
  const AuthStateChangedEvent({this.user});
  final User? user;

  @override
  List<Object?> get props => [user];
}

class SignOutEvent extends AuthEvent {}

class SubmitSignInEvent extends AuthEvent {
  const SubmitSignInEvent({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
