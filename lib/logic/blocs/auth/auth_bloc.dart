import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/utils/injector.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final StreamSubscription authSubscription;
  final AuthRepository authRepository = locator.get<AuthRepository>();

  AuthBloc() : super(const AuthInitialState()) {
    authSubscription = authRepository.user.listen((fb_auth.User? user) {
      add(AuthStateChangedEvent(user: user));
    });

    on<AuthStateChangedEvent>(
      (event, emit) {
        if (event.user != null) {
          emit(AuthenticatedState(user: event.user));
        } else {
          emit(const UnauthenticatedState());
        }
      },
    );

    on<SignOutEvent>(
      (event, emit) async {
        await authRepository.singOut();
        emit(const UnauthenticatedState());
      },
    );
  }
}
