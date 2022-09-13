import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/models/custom_error.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepository;
  SignupBloc(
    this.authRepository,
  ) : super(const SignupInitial()) {
    on<SubmitSignupEvent>(
      (event, emit) async {
        emit(const SignupSubmitted());

        try {
          await authRepository.signUp(
              name: event.name, email: event.email, password: event.password);

          emit(const SignupSuccess());
        } on CustomError catch (e) {
          emit(SignupFailed(e));
        }
      },
    );
  }
}
