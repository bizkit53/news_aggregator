import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/utils/logger.dart';
import 'package:news_aggregator/models/custom_error.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// In-app firebase user authorization handler
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Constructor
  AuthBloc({required this.authRepository}) : super(const AuthInitialState()) {
    _authSubscription = authRepository.user.listen((User? user) {
      add(AuthStateChangedEvent(user: user));
    });

    on<AuthStateChangedEvent>(_authStateChanged);
    on<SubmitSignInEvent>(_submitSignIn);
    on<SubmitSignUpEvent>(_submitSignUp);
    on<SignOutEvent>(_signOut);
  }

  FutureOr<void> _authStateChanged(
    AuthStateChangedEvent event,
    Emitter<AuthState> emit,
  ) {
    _log.i('$AuthStateChangedEvent called');

    if (event.user != null) {
      _log.i('$AuthenticatedState emitted');
      emit(AuthenticatedState(user: event.user));
    } else {
      _log.i('$UnauthenticatedState emitted');
      emit(UnauthenticatedState(error: state.error));
    }
  }

  FutureOr<void> _submitSignIn(
    SubmitSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    _log.i('$SubmitSignInEvent called');
    emit(const SignInSubmitted());

    try {
      await authRepository.signIn(
        email: event.email,
        password: event.password,
      );
    } on CustomError catch (e) {
      _log.w('$UnauthenticatedState emitted with error $e');
      emit(UnauthenticatedState(error: e));
    }
  }

  FutureOr<void> _submitSignUp(
    SubmitSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    _log.i('$SubmitSignUpEvent called');
    emit(const SignUpSubmitted());

    try {
      await authRepository.signUp(
        name: event.name,
        email: event.email,
        password: event.password,
      );
    } on CustomError catch (e) {
      _log.w('$UnauthenticatedState emitted with error $e');
      emit(UnauthenticatedState(error: e));
    }
  }

  FutureOr<void> _signOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    _log.i('$SignOutEvent called');
    await authRepository.singOut();

    _log.i('$UnauthenticatedState emitted');
    emit(const UnauthenticatedState());
  }

  /// In-app firebase user changes stream listener
  late final StreamSubscription<dynamic> _authSubscription;

  /// Authorization Firebase handler
  final AuthRepository authRepository;

  /// Log style customizer
  final Logger _log = logger(AuthBloc);

  @override
  Future<void> close() async {
    await _authSubscription.cancel();
    return super.close();
  }
}
