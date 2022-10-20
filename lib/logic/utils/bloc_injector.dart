import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_aggregator/logic/blocs/auth/auth_bloc.dart';
import 'package:news_aggregator/logic/blocs/navigation_bar/navigation_bar_bloc.dart';
import 'package:news_aggregator/logic/blocs/news/news_bloc.dart';
import 'package:news_aggregator/logic/blocs/signup/signup_bloc.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/repositories/news_repository.dart';
import 'package:news_aggregator/logic/utils/injector.dart';

/// Widget which provides all blocs to its child
class BlocInjector extends StatelessWidget {
  /// Constructor
  BlocInjector({
    super.key,
    required this.child,
  });

  /// A page for which blocs are passed
  final Widget child;

  final AuthRepository _authRepository = locator.get<AuthRepository>(
    param1: locator.get<FirebaseFirestore>(),
    param2: locator.get<FirebaseAuth>(),
  );

  final NewsRepository _newsRepository = locator.get<NewsRepository>();

  late final AuthBloc _authBloc = AuthBloc(
    authRepository: _authRepository,
  );

  late final SignupBloc _signupBloc = SignupBloc(
    authRepository: _authRepository,
  );

  late final NewsBloc _newsBloc = NewsBloc(
    newsRepository: _newsRepository,
  );

  final NavigationBarBloc _navigationBarBloc = NavigationBarBloc();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authRepository),
        RepositoryProvider.value(value: _newsRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _authBloc),
          BlocProvider.value(value: _signupBloc),
          BlocProvider.value(value: _newsBloc),
          BlocProvider.value(value: _navigationBarBloc),
        ],
        child: child,
      ),
    );
  }
}
