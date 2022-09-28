import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_aggregator/logic/repositories/news_repository.dart';
import 'package:news_aggregator/logic/services/network_services/news_network_service.dart';
import 'package:news_aggregator/models/news/news.dart';

import 'news_repository_test.mocks.dart';

@GenerateMocks([NewsNetworkService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockNewsNetworkService service;
  late NewsRepository repository;
  late List<News> result;
  late String catSearch;
  late String goalSearch;
  late String firstJsonResponse;
  late String secondJsonResponse;
  late Response<dynamic> firstResponse;
  late Response<dynamic> secondResponse;
  late RequestOptions requestOptions;
  late Map<String, dynamic> singleNewsJson;

  Future<Response<dynamic>> _getFutureResponse(Response<dynamic> response) {
    final completer = Completer<Response<dynamic>>()..complete(response);
    return completer.future;
  }

  setUpAll(() async {
    catSearch = 'cat';
    goalSearch = 'goal';
    requestOptions = RequestOptions(path: 'examplePath');

    firstJsonResponse = await rootBundle.loadString(
      'test/logic/repositories/news_repository/response_first.json',
    );
    secondJsonResponse = await rootBundle.loadString(
      'test/logic/repositories/news_repository/response_second.json',
    );

    firstResponse = Response(
      requestOptions: requestOptions,
      data: jsonDecode(firstJsonResponse),
    );
    secondResponse = Response(
      requestOptions: requestOptions,
      data: jsonDecode(secondJsonResponse),
    );
  });

  setUp(() async {
    result = [];
    service = MockNewsNetworkService();
    repository = NewsRepository(
      newsNetworkService: service,
    );
  });

  group('NewsRepository - get news:', () {
    test('single call', () async {
      when(service.getTopNews(page: 1))
          .thenAnswer((_) => _getFutureResponse(firstResponse));

      expect(result.length, 0);
      result = await repository.getNews();
      expect(result.length, 5);

      for (int i = 0; i < result.length; i++) {
        // ignore: avoid_dynamic_calls
        singleNewsJson = firstResponse.data['data'][i] as Map<String, dynamic>;
        expect(result[i], News.fromJson(singleNewsJson));
      }

      verify(service.getTopNews(page: 1)).called(1);
      verifyNoMoreInteractions(service);
    });

    test('double call', () async {
      when(service.getTopNews(page: 1))
          .thenAnswer((_) => _getFutureResponse(firstResponse));
      when(service.getTopNews(page: 2))
          .thenAnswer((_) => _getFutureResponse(secondResponse));

      expect(result.length, 0);
      result = await repository.getNews();
      expect(result.length, 5);

      result = await repository.getNews();
      expect(result.length, 10);

      verify(service.getTopNews(page: 1)).called(1);
      verify(service.getTopNews(page: 2)).called(1);
      verifyNoMoreInteractions(service);
    });
  });

  group('NewsRepository - search news:', () {
    test('single call', () async {
      when(service.searchNews(page: 1, searchPattern: goalSearch))
          .thenAnswer((_) => _getFutureResponse(firstResponse));

      expect(result.length, 0);
      result = await repository.searchNews(searchPattern: goalSearch);
      expect(result.length, 5);

      for (int i = 0; i < result.length; i++) {
        // ignore: avoid_dynamic_calls
        singleNewsJson = firstResponse.data['data'][i] as Map<String, dynamic>;
        expect(result[i], News.fromJson(singleNewsJson));
      }

      verify(service.searchNews(page: 1, searchPattern: goalSearch)).called(1);
      verifyNoMoreInteractions(service);
    });

    test('double call', () async {
      when(service.searchNews(page: 1, searchPattern: goalSearch))
          .thenAnswer((_) => _getFutureResponse(firstResponse));
      when(service.searchNews(page: 2, searchPattern: goalSearch))
          .thenAnswer((_) => _getFutureResponse(secondResponse));

      expect(result.length, 0);
      result = await repository.searchNews(searchPattern: goalSearch);
      expect(result.length, 5);

      result = await repository.searchNews(searchPattern: goalSearch);
      expect(result.length, 10);

      verify(service.searchNews(page: 1, searchPattern: goalSearch)).called(1);
      verify(service.searchNews(page: 2, searchPattern: goalSearch)).called(1);
      verifyNoMoreInteractions(service);
    });

    test('search pattern changed', () async {
      when(service.searchNews(page: 1, searchPattern: goalSearch))
          .thenAnswer((_) => _getFutureResponse(firstResponse));
      when(service.searchNews(page: 2, searchPattern: goalSearch))
          .thenAnswer((_) => _getFutureResponse(secondResponse));
      when(service.searchNews(page: 1, searchPattern: catSearch))
          .thenAnswer((_) => _getFutureResponse(firstResponse));

      expect(result.length, 0);
      result = await repository.searchNews(searchPattern: goalSearch);
      expect(result.length, 5);

      result = await repository.searchNews(searchPattern: goalSearch);
      expect(result.length, 10);

      result = await repository.searchNews(searchPattern: catSearch);
      expect(result.length, 5);

      verify(service.searchNews(page: 1, searchPattern: goalSearch)).called(1);
      verify(service.searchNews(page: 2, searchPattern: goalSearch)).called(1);
      verify(service.searchNews(page: 1, searchPattern: catSearch)).called(1);
      verifyNoMoreInteractions(service);
    });
  });
}
