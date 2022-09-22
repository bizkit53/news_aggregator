import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/utils/logger.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// In-app firebase user authorization handler
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Constructor
  AuthBloc({required this.authRepository}) : super(const AuthInitialState()) {
    authSubscription = authRepository.user.listen((User? user) {
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

  /// In-app firebase user changes stream listener
  late final StreamSubscription<dynamic> authSubscription;

  /// Authorization Firebase handler
  final AuthRepository authRepository;

  /// Log style customizer
  final Logger log = logger(AuthBloc);

  @override
  Future<void> close() async {
    await authSubscription.cancel();
    return super.close();
  }
}
