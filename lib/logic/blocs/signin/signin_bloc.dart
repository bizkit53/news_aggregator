// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/utils/injector.dart';
import 'package:news_aggregator/logic/utils/logger.dart';
import 'package:news_aggregator/models/custom_error.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthRepository authRepository = locator.get<AuthRepository>();
  final Logger log = logger(SigninBloc);

  SigninBloc() : super(const SigninInitial()) {
    on<SubmitSigninEvent>(
      (event, emit) async {
        log.i('$SubmitSigninEvent called');
        emit(const SigninSubmitted());

        try {
          await authRepository.signIn(
            email: event.email,
            password: event.password,
          );

          log.i('$SigninSuccess emitted');
          emit(const SigninSuccess());
        } on CustomError catch (e) {
          log.e('$SigninFailed emitted');
          emit(SigninFailed(e));
        }
      },
    );
  }
}
