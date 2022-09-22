// ignore_for_file: public_member_api_docs

part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStateChangedEvent extends AuthEvent {
  const AuthStateChangedEvent({this.user});
  final User? user;
}

class SignOutEvent extends AuthEvent {}
