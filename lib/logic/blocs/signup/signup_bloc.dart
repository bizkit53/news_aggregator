import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/utils/logger.dart';
import 'package:news_aggregator/models/custom_error.dart';

part 'signup_event.dart';
part 'signup_state.dart';

/// In-app firebase signing up handler
class SignupBloc extends Bloc<SignupEvent, SignupState> {
  /// Constructor
  SignupBloc({required this.authRepository}) : super(const SignupInitial()) {
    on<SubmitSignupEvent>(
      (event, emit) async {
        _log.i('$SubmitSignupEvent called');
        emit(const SignupSubmitted());

        try {
          await authRepository.signUp(
            name: event.name,
            email: event.email,
            password: event.password,
          );

          _log.i('$SignupSuccess emitted');
          emit(const SignupSuccess());
        } on CustomError catch (e) {
          _log.i('$SignupFailed emitted');
          emit(SignupFailed(e));
        }
      },
    );
  }

  /// Authorization Firebase handler
  final AuthRepository authRepository;

  /// Log style customizer
  final Logger _log = logger(SignupBloc);
}
