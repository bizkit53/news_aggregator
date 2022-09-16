import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'package:news_aggregator/constans/db_constants.dart';
import 'package:news_aggregator/logic/utils/logger.dart';
import 'package:news_aggregator/models/custom_error.dart';

/// External firebase interaction handler
@injectable
class AuthRepository {
  /// Constructor
  AuthRepository({
    @factoryParam required this.firebaseFirestore,
    @factoryParam required this.firebaseAuth,
  });

  /// Firestore instance injection
  final FirebaseFirestore firebaseFirestore;

  /// FirebaseAuth instance injection
  final fb_auth.FirebaseAuth firebaseAuth;

  /// Log style customizer
  final Logger log = logger(AuthRepository);

  /// External firebase user changes stream listener
  Stream<fb_auth.User?> get user => firebaseAuth.userChanges();

  /// Method for firebase user creation and signing in
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    log.d('signUp called with name: $name, email: $email, password: $password');

    try {
      final fb_auth.UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final singedInUser = userCredential.user!;

      await usersRef.doc(singedInUser.uid).set({
        'name': name,
        'email': email,
      });
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  /// Firebase email and password signing in handler
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    log.d('signIn called with email: $email, password: $password');

    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  /// Sign out from firebase session
  Future<void> singOut() async {
    log.d('signOut called');
    await firebaseAuth.signOut();
  }
}
