import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';

final GetIt locator = GetIt.instance;

void injectorSetup() {
  locator.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  locator.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  locator.registerSingleton<AuthRepository>(
    AuthRepository(
      firebaseFirestore: locator.get<FirebaseFirestore>(),
      firebaseAuth: locator.get<FirebaseAuth>(),
    ),
  );
}
