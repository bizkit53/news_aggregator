import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
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
  final FirebaseAuth firebaseAuth;

  /// External firebase user changes stream listener
  Stream<User?> get user => firebaseAuth.userChanges();

  /// Log style customizer
  final Logger _log = logger(AuthRepository);

  /// Firestore users collection reference variable
  late final _usersRef = firebaseFirestore.collection('users');

  /// Method for firebase user creation and signing in
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _log.d(
      'signUp called with name: $name, email: $email, password: $password',
    );

    await _customTryCatch(
      () async {
        final UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final singedInUser = userCredential.user!;

        await _usersRef.doc(singedInUser.uid).set({
          'name': name,
          'email': email,
        });
      },
    );
  }

  /// Firebase email and password signing in handler
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    _log.d('signIn called with email: $email, password: $password');

    await _customTryCatch(
      () async {
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      },
    );
  }

  /// Sign out from firebase session
  Future<void> singOut() async {
    _log.d('signOut called');
    await firebaseAuth.signOut();
  }

  /// Helper method to avoid duplicating exception catching
  Future<void> _customTryCatch(Future<void> Function() function) async {
    try {
      await function.call();
    } on FirebaseAuthException catch (e) {
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
}
