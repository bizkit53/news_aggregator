import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:logger/logger.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/utils/injector.dart';
import 'package:news_aggregator/logic/utils/logger.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// In-app firebase user authorization handler
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Constructor
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

  /// In-app firebase user changes stream listener
  late final StreamSubscription<dynamic> authSubscription;

  /// Authorization handler injection
  final AuthRepository authRepository = locator.get<AuthRepository>(
    param1: locator.get<FirebaseFirestore>(),
    param2: locator.get<fb_auth.FirebaseAuth>(),
  );

  /// Log style customizer
  final Logger log = logger(AuthBloc);

  @override
  Future<void> close() async {
    await authSubscription.cancel();
    return super.close();
  }
}
