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

  late MockNewsNetworkService newsNetworkService;
  late NewsRepository newsRepository;
  late List<News> resultList;
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
    firstJsonResponse = await rootBundle.loadString(
      'test/logic/repositories/news_repository/response_first.json',
    );
    secondJsonResponse = await rootBundle.loadString(
      'test/logic/repositories/news_repository/response_second.json',
    );
    requestOptions = RequestOptions(path: 'examplePath');
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
    resultList = [];
    newsNetworkService = MockNewsNetworkService();
    newsRepository = NewsRepository(
      newsNetworkService: newsNetworkService,
    );
  });

  group('NewsRepository - get news:', () {
    test('single call', () async {
      when(newsNetworkService.getTopNews(page: 1))
          .thenAnswer((_) => _getFutureResponse(firstResponse));

      expect(resultList.length, 0);
      resultList = await newsRepository.getNews();
      expect(resultList.length, 5);

      for (int i = 0; i < resultList.length; i++) {
        // ignore: avoid_dynamic_calls
        singleNewsJson = firstResponse.data['data'][i] as Map<String, dynamic>;
        expect(resultList[i], News.fromJson(singleNewsJson));
      }

      verify(newsNetworkService.getTopNews(page: 1)).called(1);
      verifyNoMoreInteractions(newsNetworkService);
    });

    test('double call', () async {
      when(newsNetworkService.getTopNews(page: 1))
          .thenAnswer((_) => _getFutureResponse(firstResponse));
      when(newsNetworkService.getTopNews(page: 2))
          .thenAnswer((_) => _getFutureResponse(secondResponse));

      expect(resultList.length, 0);
      resultList = await newsRepository.getNews();
      expect(resultList.length, 5);
      resultList = await newsRepository.getNews();
      expect(resultList.length, 10);

      verify(newsNetworkService.getTopNews(page: 1)).called(1);
      verify(newsNetworkService.getTopNews(page: 2)).called(1);
      verifyNoMoreInteractions(newsNetworkService);
    });
  });
}
