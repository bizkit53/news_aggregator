import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/logic/services/config_reader/config_reader.dart';
import 'package:news_aggregator/logic/utils/logger.dart';

/// News provider
@injectable
class NewsNetworkService {
  /// Constructor
  NewsNetworkService({
    @factoryParam this.apiHandler,
  }) {
    apiHandler ??= Dio(
      BaseOptions(
        baseUrl: ConfigReader.getApiURL(),
        connectTimeout: 10000,
        receiveTimeout: 10000,
        sendTimeout: 10000,
      ),
    );
  }

  /// In-app requests handler for external server
  Dio? apiHandler;

  /// Log style customizer
  final Logger _log = logger(NewsNetworkService);

  final String _topNewsEndpoint = 'v1/news/top';

  /// Send request to get top news with query parameters specified by user
  Future<Response<dynamic>> getTopNews({required int page}) {
    try {
      _setCommonParameters(page: page);
      return _getNews(_topNewsEndpoint);
    } on DioError catch (e) {
      _logError(e);
      rethrow;
    }
  }

  /// Send request to get top news based on
  Future<Response<dynamic>> searchNews({
    required int page,
    required String searchPattern,
  }) {
    try {
      _setCommonParameters(page: page);
      return _getSearchedNews(_topNewsEndpoint, searchPattern);
    } on DioError catch (e) {
      _logError(e);
      rethrow;
    }
  }

  void _setCommonParameters({required int page}) {
    // TODO(bizkit53): replace query placeholders
    apiHandler!.options.queryParameters
      ..clear()
      ..['api_token'] = ConfigReader.getApiToken()
      ..['locale'] = ''
      ..['language'] = ''
      ..['exclude_domains'] = ''
      ..['page'] = '$page';
  }

  Future<Response<dynamic>> _getNews(String path) {
    // TODO(bizkit53): replace query placeholder
    apiHandler!.options.queryParameters['categories'] = '';
    _log.d('getNews: $path');
    return apiHandler!.get(path);
  }

  Future<Response<dynamic>> _getSearchedNews(
    String path,
    String searchPattern,
  ) {
    apiHandler!.options.queryParameters['search'] = searchPattern;
    _log.d('getSearchedNews: $path with pattern $searchPattern');
    return apiHandler!.get(path);
  }

  void _logError(DioError e) {
    // The request was made and the server responded with a bad status code
    if (e.response != null) {
      _log
        ..e(e.response!.data)
        ..e(e.response!.headers)
        ..e(e.response!.requestOptions);
    } else {
      // Something happened in setting up
      // or sending the request that triggered an Error
      _log
        ..e(e.requestOptions)
        ..e(e.message);
    }
  }
}
