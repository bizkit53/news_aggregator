import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/utils/injector.dart';
import 'package:news_aggregator/logic/utils/logger.dart';
import 'package:news_aggregator/models/custom_error.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepository = locator.get<AuthRepository>();
  final Logger log = logger(SignupBloc);

  SignupBloc() : super(const SignupInitial()) {
    on<SubmitSignupEvent>(
      (event, emit) async {
        log.i('$SubmitSignupEvent called');
        emit(const SignupSubmitted());

        try {
          await authRepository.signUp(
              name: event.name, email: event.email, password: event.password);

          log.i('$SignupSuccess emitted');
          emit(const SignupSuccess());
        } on CustomError catch (e) {
          log.i('$SignupFailed emitted');
          emit(SignupFailed(e));
        }
      },
    );
  }
}