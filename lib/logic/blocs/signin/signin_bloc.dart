import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:logger/logger.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/utils/injector.dart';
import 'package:news_aggregator/logic/utils/logger.dart';
import 'package:news_aggregator/models/custom_error.dart';

part 'signin_event.dart';
part 'signin_state.dart';

/// In-app firebase signing in handler
class SigninBloc extends Bloc<SigninEvent, SigninState> {
  /// Constructor
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

  /// Authorization handler injection
  final AuthRepository authRepository = locator.get<AuthRepository>(
    param1: locator.get<FirebaseFirestore>(),
    param2: locator.get<fb_auth.FirebaseAuth>(),
  );

  /// Log style customizer
  final Logger log = logger(SigninBloc);
}
