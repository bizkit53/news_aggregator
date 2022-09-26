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

  final MockDio mockDio = MockDio();
  final BaseOptions baseOptions = BaseOptions(
    baseUrl: ConfigReader.getApiURL(),
    connectTimeout: 10000,
    receiveTimeout: 10000,
    sendTimeout: 10000,
  );

  group('NewsNetworkService - initial values', () {
    test('empty constructor', () {
      final NewsNetworkService newsNetworkService = NewsNetworkService();
      final serviceOptions = newsNetworkService.apiHandler!.options;
      when(mockDio.options).thenAnswer((_) => baseOptions);

      expect(serviceOptions.baseUrl, mockDio.options.baseUrl);
      expect(serviceOptions.sendTimeout, mockDio.options.sendTimeout);
      expect(serviceOptions.connectTimeout, mockDio.options.connectTimeout);
      expect(serviceOptions.receiveTimeout, mockDio.options.receiveTimeout);
    });

    test('passed dio instance', () {
      final NewsNetworkService newsNetworkService = NewsNetworkService(
        apiHandler: mockDio,
      );
      expect(newsNetworkService.apiHandler, mockDio);
    });
  });
}
