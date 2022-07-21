// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final fb_auth.User? user;

  const AuthState({
    this.user,
  });

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {
  const AuthInitialState() : super(user: null);
}

class AuthenticatedState extends AuthState {
  const AuthenticatedState({fb_auth.User? user}) : super(user: user);
}

class UnauthenticatedState extends AuthState {
  const UnauthenticatedState() : super(user: null);
}
