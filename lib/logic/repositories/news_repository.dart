// ignore_for_file: avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:news_aggregator/logic/services/network_services/news_network_service.dart';
import 'package:news_aggregator/models/news/news.dart';

/// In-app news service response handler
class NewsRepository {
  /// Constructor
  NewsRepository({
    required this.newsNetworkService,
  });

  /// API request handler
  final NewsNetworkService newsNetworkService;

  final List<News> _topNews = [];
  final List<News> _searchedNews = [];
  final int _limitPerRequest = 5;
  String _previousSearchPattern = '';

  /// Get the next page of top news
  List<News> getNews() {
    // TODO(bizkit53): implement
    return List<News>.empty();
  }

  /// Get the next page of news matching the search pattern
  Future<List<News>> searchNews({
    required String searchPattern,
  }) async {
    final int searchPage = _searchedNews.length ~/ _limitPerRequest + 1;

    // Clear search results when search pattern has changed
    if (searchPattern != _previousSearchPattern) {
      _searchedNews.clear();
      _previousSearchPattern = searchPattern;
    }

    final Response<dynamic> response = await newsNetworkService.searchNews(
      page: searchPage,
      searchPattern: searchPattern,
    );

    final List<dynamic> jsonList = response.data['data'] as List<dynamic>;

    // Decode json into News objects and add it to returned list
    for (final element in jsonList) {
      _searchedNews.add(
        News.fromJson(
          element as Map<String, dynamic>,
        ),
      );
    }

    return _searchedNews;
  }
}
