import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/utils/logger.dart';
import 'package:news_aggregator/models/custom_error.dart';

part 'signin_event.dart';
part 'signin_state.dart';

/// In-app firebase signing in handler
class SigninBloc extends Bloc<SigninEvent, SigninState> {
  /// Constructor
  SigninBloc({required this.authRepository}) : super(const SigninInitial()) {
    on<SubmitSigninEvent>(
      (event, emit) async {
        _log.i('$SubmitSigninEvent called');
        emit(const SigninSubmitted());

        try {
          await authRepository.signIn(
            email: event.email,
            password: event.password,
          );

          _log.i('$SigninSuccess emitted');
          emit(const SigninSuccess());
        } on CustomError catch (e) {
          _log.w('$SigninFailed emitted');
          emit(SigninFailed(e));
        }
      },
    );
  }

  /// Authorization Firebase handler
  final AuthRepository authRepository;

  /// Log style customizer
  final Logger _log = logger(SigninBloc);
}
