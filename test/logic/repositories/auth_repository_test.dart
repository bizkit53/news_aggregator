import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/services/config_reader/config_reader.dart';
import 'package:news_aggregator/logic/utils/injector.dart';
import 'package:news_aggregator/models/custom_error.dart';

import 'firebase_mock_helper.dart';

void main() async {
  late MockFirebaseAuth mockFirebaseAuth;
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late AuthRepository authRepository;
  late CollectionReference<Map<String, dynamic>> usersRef;

  const String code = 'invalid-email';
  const String message = 'exception-message';
  final FirebaseAuthException exceptionExample = FirebaseAuthException(
    code: code,
    message: message,
  );

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await ConfigReader.initialize(Environment.dev);
    setupFirebaseAuthMocks();

    await Firebase.initializeApp();
    injectorSetup();
  });

  void setUpRepository() {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    usersRef = fakeFirebaseFirestore.collection('users');
    authRepository = locator.get<AuthRepository>(
      param1: fakeFirebaseFirestore,
      param2: mockFirebaseAuth,
    );
  }

  group('AuthRepository - sign in:', () {
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
      mockFirebaseAuth = MockFirebaseAuth(
        authExceptions: AuthExceptions(
          signInWithEmailAndPassword: exceptionExample,
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

  group('AuthRepository - sign up:', () {
    int usersCount;
    test('successful', () async {
      mockFirebaseAuth = MockFirebaseAuth();
      setUpRepository();

      usersCount = await usersRef.get().then((value) => value.docs.length);
      expect(mockFirebaseAuth.currentUser, null);
      expect(usersCount, 0);

      await authRepository.signUp(
        name: 'bob',
        email: 'bob@somedomain.com',
        password: 'password',
      );

      usersCount = await usersRef.get().then((value) => value.docs.length);
      expect(mockFirebaseAuth.currentUser, isA<MockUser>());
      expect(usersCount, 1);
    });

    test('failed - CustomError thrown', () async {
      mockFirebaseAuth = MockFirebaseAuth(
        authExceptions: AuthExceptions(
          createUserWithEmailAndPassword: exceptionExample,
        ),
      );
      setUpRepository();

      usersCount = await usersRef.get().then((value) => value.docs.length);
      expect(mockFirebaseAuth.currentUser, null);
      expect(usersCount, 0);

      expect(
        () => authRepository.signUp(
          name: 'bob',
          email: 'bobsomedomain.com',
          password: 'password',
        ),
        throwsA(
          predicate(
            (e) => e is CustomError && e.code == code && e.message == message,
          ),
        ),
      );

      usersCount = await usersRef.get().then((value) => value.docs.length);
      expect(mockFirebaseAuth.currentUser, null);
      expect(usersCount, 0);
    });
  });

  group('AuthRepository - sign out:', () {
    test('successful', () async {
      mockFirebaseAuth = MockFirebaseAuth();
      setUpRepository();
      await authRepository.signIn(
        email: 'bob@somedomain.com',
        password: 'password',
      );

      expect(mockFirebaseAuth.currentUser, isA<MockUser>());

      await authRepository.singOut();

      expect(mockFirebaseAuth.currentUser, null);
    });
  });
}
