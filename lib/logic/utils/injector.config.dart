// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:dio/dio.dart' as _i7;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../repositories/auth_repository.dart' as _i3;
import '../services/network_services/news_network_service.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factoryParam<_i3.AuthRepository, _i4.FirebaseFirestore, _i5.FirebaseAuth>((
    firebaseFirestore,
    firebaseAuth,
  ) =>
      _i3.AuthRepository(
        firebaseFirestore: firebaseFirestore,
        firebaseAuth: firebaseAuth,
      ));
  gh.factoryParam<_i6.NewsNetworkService, _i7.Dio?, dynamic>((
    apiHandler,
    _,
  ) =>
      _i6.NewsNetworkService(apiHandler: apiHandler));
  return get;
}
