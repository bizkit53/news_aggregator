import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_aggregator/logic/blocs/auth/auth_bloc.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/models/custom_error.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository, User])
void main() {
  late MockAuthRepository mockAuthRepository;
  late MockUser mockUser;
  late final CustomError customError;
  late final String email;
  late final String password;

  setUpAll(() {
    email = 'bob@somedomain.com';
    password = 'password';
    customError = const CustomError(
      code: '400',
      message: 'error message',
      plugin: 'FirebaseAuth',
    );
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockUser = MockUser();
  });

  group('AuthBloc - auth state changed:', () {
    test('initial state is correct', () {
      when(mockAuthRepository.user).thenAnswer(
        (realInvocation) => Stream<User?>.fromIterable([null]),
      );
      expect(
        AuthBloc(authRepository: mockAuthRepository).state,
        const AuthInitialState(),
      );
    });

    blocTest<AuthBloc, AuthState>(
      'unauthorized when no events called',
      build: () {
        when(mockAuthRepository.user).thenAnswer(
          (realInvocation) => Stream<User?>.fromIterable([null]),
        );
        return AuthBloc(authRepository: mockAuthRepository);
      },
      expect: () => <AuthState>[
        const UnauthenticatedState(),
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
      expect: () => <AuthState>[
        const UnauthenticatedState(),
        AuthenticatedState(user: mockUser),
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
      expect: () => <AuthState>[
        const UnauthenticatedState(),
        AuthenticatedState(user: mockUser),
        const UnauthenticatedState(),
      ],
    );
  });

  group('AuthBloc - sign out:', () {
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
      expect: () => <AuthState>[
        AuthenticatedState(user: mockUser),
        const UnauthenticatedState(),
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

  group(
    'AuthBloc - sign in:',
    () {
      blocTest<AuthBloc, AuthState>(
        'successful',
        build: () {
          when(mockAuthRepository.user).thenAnswer(
            (realInvocation) => Stream<User?>.fromIterable([mockUser]),
          );
          return AuthBloc(authRepository: mockAuthRepository);
        },
        act: (bloc) => bloc.add(
          SubmitSignInEvent(
            email: email,
            password: password,
          ),
        ),
        expect: () => <AuthState>[
          const SignInSubmitted(),
          AuthenticatedState(user: mockUser),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'failed - CustomError thrown',
        build: () {
          when(mockAuthRepository.user).thenAnswer(
            (realInvocation) => Stream<User?>.fromIterable([null]),
          );
          when(
            mockAuthRepository.signIn(
              email: email,
              password: password,
            ),
          ).thenThrow(customError);
          return AuthBloc(authRepository: mockAuthRepository);
        },
        act: (bloc) => bloc.add(
          SubmitSignInEvent(
            email: email,
            password: password,
          ),
        ),
        expect: () => <AuthState>[
          const SignInSubmitted(),
          UnauthenticatedState(error: customError),
        ],
      );
    },
  );
}
