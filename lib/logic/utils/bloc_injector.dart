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
  const BlocInjector({
    Key? key,
    required this.child,
  }) : super(key: key);

  /// A page for which blocs are passed
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => locator.get<AuthRepository>(
        param1: locator.get<FirebaseFirestore>(),
        param2: locator.get<FirebaseAuth>(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SigninBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignupBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
