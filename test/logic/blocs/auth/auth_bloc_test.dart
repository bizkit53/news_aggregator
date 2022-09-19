import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_aggregator/logic/blocs/auth/auth_bloc.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository, User])
void main() {
  final MockAuthRepository mockAuthRepository = MockAuthRepository();
  final MockUser mockUser = MockUser();

  group('auth state changed', () {
    blocTest<AuthBloc, AuthState>(
      'unauthorized when no events called',
      build: () {
        when(mockAuthRepository.user).thenAnswer(
          (realInvocation) => Stream<User?>.fromIterable([null]),
        );
        return AuthBloc(authRepository: mockAuthRepository);
      },
      expect: () => const <AuthState>[
        UnauthenticatedState(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'authorized should stay authorized',
      build: () {
        when(mockAuthRepository.user).thenAnswer(
          (realInvocation) =>
              Stream<User?>.fromIterable([mockUser, mockUser, mockUser]),
        );
        return AuthBloc(authRepository: mockAuthRepository);
      },
      act: (bloc) {
        bloc
          ..add(const AuthStateChangedEvent())
          ..add(const AuthStateChangedEvent())
          ..add(const AuthStateChangedEvent());
      },
      expect: () => const <AuthState>[
        UnauthenticatedState(),
        AuthenticatedState(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'unauthorized should stay unauthorized',
      build: () {
        when(mockAuthRepository.user).thenAnswer(
          (realInvocation) => Stream<User?>.fromIterable([null, null, null]),
        );
        return AuthBloc(authRepository: mockAuthRepository);
      },
      act: (bloc) {
        bloc
          ..add(const AuthStateChangedEvent())
          ..add(const AuthStateChangedEvent())
          ..add(const AuthStateChangedEvent());
      },
      expect: () => const <AuthState>[
        UnauthenticatedState(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      '3x AuthStateChanged',
      build: () {
        when(mockAuthRepository.user).thenAnswer(
          (realInvocation) =>
              Stream<User?>.fromIterable([null, mockUser, null]),
        );
        return AuthBloc(authRepository: mockAuthRepository);
      },
      act: (bloc) {
        bloc
          ..add(const AuthStateChangedEvent())
          ..add(const AuthStateChangedEvent())
          ..add(const AuthStateChangedEvent());
      },
      expect: () => const <AuthState>[
        UnauthenticatedState(),
        AuthenticatedState(),
        UnauthenticatedState(),
      ],
    );
  });

  group('sign out', () {
    blocTest<AuthBloc, AuthState>(
      'sign out from signed in',
      build: () {
        when(mockAuthRepository.user).thenAnswer(
          (realInvocation) => Stream<User?>.fromIterable([mockUser]),
        );
        return AuthBloc(authRepository: mockAuthRepository);
      },
      act: (bloc) {
        bloc.add(SignOutEvent());
      },
      expect: () => const <AuthState>[
        AuthenticatedState(),
        UnauthenticatedState(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'sign out from signed out',
      build: () {
        when(mockAuthRepository.user).thenAnswer(
          (realInvocation) => Stream<User?>.fromIterable([null]),
        );
        return AuthBloc(authRepository: mockAuthRepository);
      },
      act: (bloc) {
        bloc.add(SignOutEvent());
      },
      expect: () => const <AuthState>[
        UnauthenticatedState(),
      ],
    );
  });
}
