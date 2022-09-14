import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:logger/logger.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/utils/injector.dart';
import 'package:news_aggregator/logic/utils/logger.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final StreamSubscription authSubscription;
  final AuthRepository authRepository = locator.get<AuthRepository>();
  final Logger log = logger(AuthBloc);

  AuthBloc() : super(const AuthInitialState()) {
    authSubscription = authRepository.user.listen((fb_auth.User? user) {
      add(AuthStateChangedEvent(user: user));
    });

    on<AuthStateChangedEvent>(
      (event, emit) {
        log.i('$AuthStateChangedEvent called');
        if (event.user != null) {
          log.i('$AuthenticatedState emitted');
          emit(AuthenticatedState(user: event.user));
        } else {
          log.i('$UnauthenticatedState emitted');
          emit(const UnauthenticatedState());
        }
      },
    );

    on<SignOutEvent>(
      (event, emit) async {
        log.i('$SignOutEvent called');
        await authRepository.singOut();
        log.i('$UnauthenticatedState emitted');
        emit(const UnauthenticatedState());
      },
    );
  }

  @override
  Future<void> close() async {
    await authSubscription.cancel();
    return super.close();
  }
}
