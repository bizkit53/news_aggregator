import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_aggregator/constans/environment.dart';
import 'package:news_aggregator/logic/services/config_reader/config_reader.dart';
import 'package:news_aggregator/logic/services/network_services/news_network_service.dart';

import 'news_network_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize(Environment.dev);

  late String examplePath;
  late BaseOptions baseOptions;
  late RequestOptions requestOptions;
  late MockDio mockDio;
  late NewsNetworkService newsNetworkService;
  late Response<dynamic> exampleSuccessfulResponse;

  Future<Response<dynamic>> _getFutureResponse() {
    final completer = Completer<Response<dynamic>>()
      ..complete(exampleSuccessfulResponse);

    return completer.future;
  }

  setUpAll(() {
    examplePath = 'v1/news/top';
    requestOptions = RequestOptions(
      path: examplePath,
    );
    baseOptions = BaseOptions(
      baseUrl: ConfigReader.getApiURL(),
      connectTimeout: 10000,
      receiveTimeout: 10000,
      sendTimeout: 10000,
    );
    exampleSuccessfulResponse = Response<dynamic>(
      requestOptions: requestOptions,
      data: {
        'meta': {'found': 11965, 'returned': 5, 'limit': 5, 'page': 1},
        'data': [
          {
            'uuid': '123abc',
            'title': 'title',
            'description': 'description',
            'keywords': 'key, word',
            'snippet': 'snippet',
            'url': 'https://www.example.com',
            'image_url': 'https://example.com/media/image.png',
            'language': 'en',
            'published_at': '2022-09-20T18:31:00.000000Z',
            'source': 'example.com',
            'categories': ['tech'],
            'relevance_score': 26.651016,
            'locale': 'en'
          }
        ]
      },
    );
  });

  setUp(() {
    mockDio = MockDio();
    newsNetworkService = NewsNetworkService(apiHandler: mockDio);
    when(mockDio.options).thenAnswer((_) => baseOptions);
  });

  group('NewsNetworkService - initial values:', () {
    test('empty constructor', () {
      newsNetworkService = NewsNetworkService();
      final serviceOptions = newsNetworkService.apiHandler!.options;

      expect(serviceOptions.baseUrl, mockDio.options.baseUrl);
      expect(serviceOptions.sendTimeout, mockDio.options.sendTimeout);
      expect(serviceOptions.connectTimeout, mockDio.options.connectTimeout);
      expect(serviceOptions.receiveTimeout, mockDio.options.receiveTimeout);

      verify(mockDio.options).called(4);
      verifyNoMoreInteractions(mockDio);
    });

    test('passed dio instance', () {
      expect(newsNetworkService.apiHandler, mockDio);
      verifyZeroInteractions(mockDio);
    });
  });

  group('NewsNetworkService - get top news:', () {
    test('successful', () async {
      when(mockDio.get<dynamic>(examplePath)).thenAnswer(
        (_) => _getFutureResponse(),
      );
      expect(
        newsNetworkService.getTopNews(page: 1),
        isA<Future<Response<dynamic>>>(),
      );
      expect(
        await newsNetworkService.getTopNews(page: 1),
        await _getFutureResponse(),
      );

      verify(mockDio.options).called(4);
      verify(mockDio.get<dynamic>(examplePath)).called(2);
      verifyNoMoreInteractions(mockDio);
    });

    test('failed - connect timeout', () {
      when(
        mockDio.get<dynamic>(examplePath),
      ).thenThrow(
        DioError(
          requestOptions: requestOptions,
          type: DioErrorType.connectTimeout,
        ),
      );

      expect(
        () => newsNetworkService.getTopNews(page: 1),
        throwsA(
          predicate(
            (e) =>
                e is DioError &&
                e.requestOptions == requestOptions &&
                e.type == DioErrorType.connectTimeout,
          ),
        ),
      );

      verify(mockDio.options).called(2);
      verify(mockDio.get<dynamic>(examplePath)).called(1);
      verifyNoMoreInteractions(mockDio);
    });

    test('failed - send timeout', () {
      when(
        mockDio.get<dynamic>(examplePath),
      ).thenThrow(
        DioError(
          requestOptions: requestOptions,
          type: DioErrorType.sendTimeout,
        ),
      );

      expect(
        () => newsNetworkService.getTopNews(page: 1),
        throwsA(
          predicate(
            (e) =>
                e is DioError &&
                e.requestOptions == requestOptions &&
                e.type == DioErrorType.sendTimeout,
          ),
        ),
      );

      verify(mockDio.options).called(2);
      verify(mockDio.get<dynamic>(examplePath)).called(1);
      verifyNoMoreInteractions(mockDio);
    });

    test('failed - receive timeout', () {
      when(
        mockDio.get<dynamic>(examplePath),
      ).thenThrow(
        DioError(
          requestOptions: requestOptions,
          type: DioErrorType.receiveTimeout,
        ),
      );

      expect(
        () => newsNetworkService.getTopNews(page: 1),
        throwsA(
          predicate(
            (e) =>
                e is DioError &&
                e.requestOptions == requestOptions &&
                e.type == DioErrorType.receiveTimeout,
          ),
        ),
      );

      verify(mockDio.options).called(2);
      verify(mockDio.get<dynamic>(examplePath)).called(1);
      verifyNoMoreInteractions(mockDio);
    });

    test('failed - request cancelled', () {
      when(
        mockDio.get<dynamic>(examplePath),
      ).thenThrow(
        DioError(
          requestOptions: requestOptions,
          type: DioErrorType.cancel,
        ),
      );

      expect(
        () => newsNetworkService.getTopNews(page: 1),
        throwsA(
          predicate(
            (e) =>
                e is DioError &&
                e.requestOptions == requestOptions &&
                e.type == DioErrorType.cancel,
          ),
        ),
      );

      verify(mockDio.options).called(2);
      verify(mockDio.get<dynamic>(examplePath)).called(1);
      verifyNoMoreInteractions(mockDio);
    });

    test('failed - bad response', () {
      when(
        mockDio.get<dynamic>(examplePath),
      ).thenThrow(
        DioError(
          requestOptions: requestOptions,
          type: DioErrorType.response,
        ),
      );

      expect(
        () => newsNetworkService.getTopNews(page: 1),
        throwsA(
          predicate(
            (e) =>
                e is DioError &&
                e.requestOptions == requestOptions &&
                e.type == DioErrorType.response,
          ),
        ),
      );

      verify(mockDio.options).called(2);
      verify(mockDio.get<dynamic>(examplePath)).called(1);
      verifyNoMoreInteractions(mockDio);
    });

    test('failed - default error', () {
      when(
        mockDio.get<dynamic>(examplePath),
      ).thenThrow(
        DioError(
          requestOptions: requestOptions,
        ),
      );

      expect(
        () => newsNetworkService.getTopNews(page: 1),
        throwsA(
          predicate(
            (e) =>
                e is DioError &&
                e.requestOptions == requestOptions &&
                e.type == DioErrorType.other,
          ),
        ),
      );

      verify(mockDio.options).called(2);
      verify(mockDio.get<dynamic>(examplePath)).called(1);
      verifyNoMoreInteractions(mockDio);
    });
  });
}
