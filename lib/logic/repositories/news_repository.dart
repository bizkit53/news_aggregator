// ignore_for_file: avoid_dynamic_calls

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_aggregator/logic/services/network_services/news_network_service.dart';
import 'package:news_aggregator/models/news/news.dart';

/// In-app news service response handler
@singleton
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
  Future<List<News>> getNews() async {
    final int searchPage = _getNextPageNumber(targetList: _topNews);

    final Response<dynamic> response = await newsNetworkService.getTopNews(
      page: searchPage,
    );

    _decodeNews(response: response, targetList: _topNews);
    log(response.data.toString());
    return _topNews;
  }

  /// Get the next page of news matching the search pattern
  Future<List<News>> searchNews({
    required String searchPattern,
  }) async {
    // Clear search results when search pattern has changed
    if (searchPattern != _previousSearchPattern) {
      _searchedNews.clear();
      _previousSearchPattern = searchPattern;
    }

    final int searchPage = _getNextPageNumber(targetList: _searchedNews);
    final Response<dynamic> response = await newsNetworkService.searchNews(
      page: searchPage,
      searchPattern: searchPattern,
    );

    _decodeNews(response: response, targetList: _searchedNews);

    return _searchedNews;
  }

  int _getNextPageNumber({required List<News> targetList}) {
    return targetList.length ~/ _limitPerRequest + 1;
  }

  void _decodeNews({
    required Response<dynamic> response,
    required List<News> targetList,
  }) {
    final List<dynamic> jsonList = response.data['data'] as List<dynamic>;

    // Decode json into News objects and add it to returned list
    for (final element in jsonList) {
      targetList.add(
        News.fromJson(
          element as Map<String, dynamic>,
        ),
      );
    }
  }
}
