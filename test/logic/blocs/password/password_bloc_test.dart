import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_aggregator/logic/blocs/password/password_bloc.dart';

void main() {
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
}
