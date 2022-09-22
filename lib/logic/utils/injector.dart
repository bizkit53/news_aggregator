import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:news_aggregator/logic/utils/injector.config.dart';

/// Instance of dependency injection service
final GetIt locator = GetIt.instance;

/// Register dependencies so they can be injected elsewhere
@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void injectorSetup() {
  locator
    ..registerSingleton<FirebaseAuth>(FirebaseAuth.instance)
    ..registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  $initGetIt(locator);
}
