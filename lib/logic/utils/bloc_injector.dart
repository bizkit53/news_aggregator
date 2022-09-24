import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_aggregator/logic/blocs/auth/auth_bloc.dart';
import 'package:news_aggregator/logic/blocs/signin/signin_bloc.dart';
import 'package:news_aggregator/logic/blocs/signup/signup_bloc.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/utils/injector.dart';

/// Widget which provides all blocs to its child
class BlocInjector extends StatelessWidget {
  /// Constructor
  BlocInjector({
    Key? key,
    required this.child,
  }) : super(key: key);

  /// A page for which blocs are passed
  final Widget child;

  final AuthRepository _authRepository = locator.get<AuthRepository>(
    param1: locator.get<FirebaseFirestore>(),
    param2: locator.get<FirebaseAuth>(),
  );

  late final AuthBloc _authBloc = AuthBloc(
    authRepository: _authRepository,
  );

  late final SigninBloc _signinBloc = SigninBloc(
    authRepository: _authRepository,
  );

  late final SignupBloc _signupBloc = SignupBloc(
    authRepository: _authRepository,
  );

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _authBloc),
          BlocProvider.value(value: _signinBloc),
          BlocProvider.value(value: _signupBloc),
        ],
        child: child,
      ),
    );
  }
}
