import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_aggregator/logic/blocs/password/password_bloc.dart';

void main() {
  late String longPassword;
  late String shortPassword;
  late String emptyPassword;
  late String noDigitPassword;
  late String noLowerCasePassword;
  late String noUpperCasePassword;
  late String noSpecialSignPassword;
  late String shortestValidPassword;
  late String longestValidPassword;

  setUpAll(() {
    longPassword = '1234567890abcdef1234567890ABCDEF!@#%';
    shortPassword = 'Ab1!@%';
    emptyPassword = '';
    noDigitPassword = 'ABCDEFabcdef!@%';
    noLowerCasePassword = 'ABCDEF123!@%';
    noUpperCasePassword = 'abcdef123!@%';
    noSpecialSignPassword = 'ABCDEFabcdef123';
    shortestValidPassword = 'ABcd12!@';
    longestValidPassword = 'ABCDEabcde12345!@#%^';
  });

  test('initial state is correct', () {
    expect(
      PasswordBloc().state,
      PasswordInitial(),
    );
    expect(PasswordBloc().state.isHidden, true);
    expect(PasswordBloc().state.isPasswordValid, false);
    expect(PasswordBloc().state.isConfirmPasswordValid, false);
  });

  group('PasswordBloc - visibility changed:', () {
    blocTest<PasswordBloc, PasswordState>(
      'visibility changed to visible',
      build: PasswordBloc.new,
      act: (bloc) => bloc.add(PasswordVisibilityChangedEvent()),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: false,
          isPasswordValid: false,
          isConfirmPasswordValid: false,
        ),
      ],
    );

    blocTest<PasswordBloc, PasswordState>(
      'visibility changed to hidden',
      build: PasswordBloc.new,
      act: (bloc) => bloc
        ..add(PasswordVisibilityChangedEvent())
        ..add(PasswordVisibilityChangedEvent()),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: false,
          isPasswordValid: false,
          isConfirmPasswordValid: false,
        ),
        const PasswordFieldChanged(
          isHidden: true,
          isPasswordValid: false,
          isConfirmPasswordValid: false,
        ),
      ],
    );
  });

  group('PasswordBloc - password validation:', () {
    blocTest<PasswordBloc, PasswordState>(
      'invalid - long',
      build: PasswordBloc.new,
      act: (bloc) => bloc.add(
        PasswordValidationEvent(password: longPassword),
      ),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: true,
          isPasswordValid: false,
          isConfirmPasswordValid: false,
        ),
      ],
    );

    blocTest<PasswordBloc, PasswordState>(
      'invalid - short',
      build: PasswordBloc.new,
      act: (bloc) => bloc.add(
        PasswordValidationEvent(password: shortPassword),
      ),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: true,
          isPasswordValid: false,
          isConfirmPasswordValid: false,
        ),
      ],
    );

    blocTest<PasswordBloc, PasswordState>(
      'invalid - empty',
      build: PasswordBloc.new,
      act: (bloc) => bloc.add(
        PasswordValidationEvent(password: emptyPassword),
      ),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: true,
          isPasswordValid: false,
          isConfirmPasswordValid: false,
        ),
      ],
    );

    blocTest<PasswordBloc, PasswordState>(
      'invalid - no digit',
      build: PasswordBloc.new,
      act: (bloc) => bloc.add(
        PasswordValidationEvent(password: noDigitPassword),
      ),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: true,
          isPasswordValid: false,
          isConfirmPasswordValid: false,
        ),
      ],
    );

    blocTest<PasswordBloc, PasswordState>(
      'invalid - no lower case letter',
      build: PasswordBloc.new,
      act: (bloc) => bloc.add(
        PasswordValidationEvent(password: noLowerCasePassword),
      ),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: true,
          isPasswordValid: false,
          isConfirmPasswordValid: false,
        ),
      ],
    );

    blocTest<PasswordBloc, PasswordState>(
      'invalid - no upper case letter',
      build: PasswordBloc.new,
      act: (bloc) => bloc.add(
        PasswordValidationEvent(password: noUpperCasePassword),
      ),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: true,
          isPasswordValid: false,
          isConfirmPasswordValid: false,
        ),
      ],
    );

    blocTest<PasswordBloc, PasswordState>(
      'valid - no special sign',
      build: PasswordBloc.new,
      act: (bloc) => bloc.add(
        PasswordValidationEvent(password: noSpecialSignPassword),
      ),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: true,
          isPasswordValid: true,
          isConfirmPasswordValid: false,
        ),
      ],
    );

    blocTest<PasswordBloc, PasswordState>(
      'valid - shortest possible',
      build: PasswordBloc.new,
      act: (bloc) => bloc.add(
        PasswordValidationEvent(password: shortestValidPassword),
      ),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: true,
          isPasswordValid: true,
          isConfirmPasswordValid: false,
        ),
      ],
    );

    blocTest<PasswordBloc, PasswordState>(
      'valid - longest possible',
      build: PasswordBloc.new,
      act: (bloc) => bloc.add(
        PasswordValidationEvent(password: longestValidPassword),
      ),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: true,
          isPasswordValid: true,
          isConfirmPasswordValid: false,
        ),
      ],
    );
  });

  group('PasswordBloc - confirm password validation:', () {
    blocTest<PasswordBloc, PasswordState>(
      'invalid - empty password',
      build: PasswordBloc.new,
      act: (bloc) => bloc.add(
        ConfirmPasswordValidationEvent(
          password: emptyPassword,
          confirmPassword: longestValidPassword,
        ),
      ),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: true,
          isPasswordValid: false,
          isConfirmPasswordValid: false,
        ),
      ],
    );

    blocTest<PasswordBloc, PasswordState>(
      'invalid - weak password',
      build: PasswordBloc.new,
      act: (bloc) => bloc.add(
        ConfirmPasswordValidationEvent(
          password: noLowerCasePassword,
          confirmPassword: longestValidPassword,
        ),
      ),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: true,
          isPasswordValid: false,
          isConfirmPasswordValid: false,
        ),
      ],
    );

    blocTest<PasswordBloc, PasswordState>(
      'invalid - empty confirm password',
      build: PasswordBloc.new,
      act: (bloc) => bloc.add(
        ConfirmPasswordValidationEvent(
          password: shortestValidPassword,
          confirmPassword: emptyPassword,
        ),
      ),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: true,
          isPasswordValid: true,
          isConfirmPasswordValid: false,
        ),
      ],
    );

    blocTest<PasswordBloc, PasswordState>(
      'invalid - different strings',
      build: PasswordBloc.new,
      act: (bloc) => bloc.add(
        ConfirmPasswordValidationEvent(
          password: shortestValidPassword,
          confirmPassword: longestValidPassword,
        ),
      ),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: true,
          isPasswordValid: true,
          isConfirmPasswordValid: false,
        ),
      ],
    );

    blocTest<PasswordBloc, PasswordState>(
      'invalid - equal invalid strings',
      build: PasswordBloc.new,
      act: (bloc) => bloc.add(
        ConfirmPasswordValidationEvent(
          password: noUpperCasePassword,
          confirmPassword: noUpperCasePassword,
        ),
      ),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: true,
          isPasswordValid: false,
          isConfirmPasswordValid: true,
        ),
      ],
    );

    blocTest<PasswordBloc, PasswordState>(
      'valid - equal strings',
      build: PasswordBloc.new,
      act: (bloc) => bloc.add(
        ConfirmPasswordValidationEvent(
          password: longestValidPassword,
          confirmPassword: longestValidPassword,
        ),
      ),
      expect: () => <PasswordState>[
        const PasswordFieldChanged(
          isHidden: true,
          isPasswordValid: true,
          isConfirmPasswordValid: true,
        ),
      ],
    );
  });
}
