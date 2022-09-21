import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news_aggregator/logic/blocs/signin/signin_bloc.dart';
import 'package:news_aggregator/models/custom_error.dart';

import '../auth/auth_bloc_test.mocks.dart';

void main() {
  final MockAuthRepository mockAuthRepository = MockAuthRepository();
  final MockUser mockUser = MockUser();

  const CustomError customError = CustomError(
    code: '400',
    message: 'error message',
    plugin: 'FirebaseAuth',
  );

  const String email = 'bob@somedomain.com';
  const String password = 'password';

  group(
    'SignInBloc - sign in:',
    () {
      test('initial state is correct', () {
        when(mockAuthRepository.user).thenAnswer(
          (realInvocation) => Stream<User?>.fromIterable([null]),
        );
        expect(
          SigninBloc(authRepository: mockAuthRepository).state,
          const SigninInitial(),
        );
      });

      blocTest<SigninBloc, SigninState>(
        'successful',
        build: () {
          when(mockAuthRepository.user).thenAnswer(
            (realInvocation) => Stream<User?>.fromIterable([mockUser]),
          );
          return SigninBloc(authRepository: mockAuthRepository);
        },
        act: (bloc) => bloc.add(
          const SubmitSigninEvent(
            email: email,
            password: password,
          ),
        ),
        expect: () => const <SigninState>[
          SigninSubmitted(),
          SigninSuccess(),
        ],
      );

      blocTest<SigninBloc, SigninState>(
        'failed - CustomError thrown',
        build: () {
          when(
            mockAuthRepository.signIn(
              email: email,
              password: password,
            ),
          ).thenThrow(
            customError,
          );
          return SigninBloc(authRepository: mockAuthRepository);
        },
        act: (bloc) => bloc.add(
          const SubmitSigninEvent(
            email: email,
            password: password,
          ),
        ),
        expect: () => const <SigninState>[
          SigninSubmitted(),
          SigninFailed(customError),
        ],
      );
    },
  );
}
