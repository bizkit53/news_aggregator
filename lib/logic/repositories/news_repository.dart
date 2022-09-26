// ignore_for_file: avoid_dynamic_calls

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

  /// Get the next page of top news
  List<News> getNews() {
    // TODO(bizkit53): implement
    return List<News>.empty();
  }

  /// Get the next page of news matching the search pattern
  List<News> searchNews({
    required String searchPattern,
  }) {
    // TODO(bizkit53): implement
    return List<News>.empty();
  }
}
