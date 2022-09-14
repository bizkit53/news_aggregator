import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';

/// Instance of dependency injection service
final GetIt locator = GetIt.instance;

/// Register dependencies so they can be injected elsewhere
void injectorSetup() {
  locator
    ..registerSingleton<FirebaseAuth>(FirebaseAuth.instance)
    ..registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance)
    ..registerSingleton<AuthRepository>(AuthRepository());
}
