import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news_aggregator/logic/blocs/signup/signup_bloc.dart';
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

  const String name = 'Bob';
  const String email = 'bob@somedomain.com';
  const String password = 'password';

  group(
    'SignUpBloc - sign up:',
    () {
      test('initial state is correct', () {
        when(mockAuthRepository.user).thenAnswer(
          (realInvocation) => Stream<User?>.fromIterable([null]),
        );
        expect(
          SignupBloc(authRepository: mockAuthRepository).state,
          const SignupInitial(),
        );
      });

      blocTest<SignupBloc, SignupState>(
        'successful',
        build: () {
          when(mockAuthRepository.user).thenAnswer(
            (realInvocation) => Stream<User?>.fromIterable([mockUser]),
          );
          return SignupBloc(authRepository: mockAuthRepository);
        },
        act: (bloc) => bloc.add(
          const SubmitSignupEvent(
            name: name,
            email: email,
            password: password,
          ),
        ),
        expect: () => const <SignupState>[
          SignupSubmitted(),
          SignupSuccess(),
        ],
      );

      blocTest<SignupBloc, SignupState>(
        'failed - CustomError thrown',
        build: () {
          when(
            mockAuthRepository.signUp(
              name: name,
              email: email,
              password: password,
            ),
          ).thenThrow(
            customError,
          );
          return SignupBloc(authRepository: mockAuthRepository);
        },
        act: (bloc) => bloc.add(
          const SubmitSignupEvent(
            name: name,
            email: email,
            password: password,
          ),
        ),
        expect: () => const <SignupState>[
          SignupSubmitted(),
          SignupFailed(customError),
        ],
      );
    },
  );
}
