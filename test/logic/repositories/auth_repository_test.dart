import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/utils/injector.dart';
import 'package:news_aggregator/models/custom_error.dart';

import 'firebase_mock_helper.dart';

void main() async {
  late MockFirebaseAuth mockFirebaseAuth;
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late AuthRepository authRepository;

  setUpAll(() async {
    setupFirebaseAuthMocks();

    await Firebase.initializeApp();
    injectorSetup();
  });

  void setUpRepository() {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    authRepository = locator.get<AuthRepository>(
      param1: fakeFirebaseFirestore,
      param2: mockFirebaseAuth,
    );
  }

  group('signIn', () {
    test('successful', () async {
      mockFirebaseAuth = MockFirebaseAuth();
      setUpRepository();
      expect(mockFirebaseAuth.currentUser, null);

      await authRepository.signIn(
        email: 'bob@somedomain.com',
        password: 'password',
      );

      expect(mockFirebaseAuth.currentUser, isA<MockUser>());
    });

    test('failed - CustomError thrown', () {
      const String code = 'invalid-email';
      const String message = 'exception-message';
      mockFirebaseAuth = MockFirebaseAuth(
        authExceptions: AuthExceptions(
          signInWithEmailAndPassword: FirebaseAuthException(
            code: code,
            message: message,
          ),
        ),
      );
      setUpRepository();

      expect(
        () => authRepository.signIn(
          email: 'bobsomedomain.com',
          password: 'password',
        ),
        throwsA(
          predicate(
            (e) => e is CustomError && e.code == code && e.message == message,
          ),
        ),
      );
    });
  });
}
