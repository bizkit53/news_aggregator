import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_aggregator/logic/repositories/auth_repository.dart';
import 'package:news_aggregator/logic/utils/injector.dart';

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

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    authRepository = locator.get<AuthRepository>(
      param1: fakeFirebaseFirestore,
      param2: mockFirebaseAuth,
    );
  });
}
