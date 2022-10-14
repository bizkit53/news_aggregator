import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/logic/repositories/news_repository.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';
import 'package:news_aggregator/models/news/news.dart';

part 'news_event.dart';
part 'news_state.dart';

/// News provider for feed page
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  /// Constructor
  NewsBloc({required this.newsRepository}) : super(const NewsInitial()) {
    List<News> resultList = [];

    on<GetTopNewsEvent>((event, emit) async {
      _log
        ..i('$GetTopNewsEvent called')
        ..i('$NewsLoading emitted');
      emit(NewsLoading(newsList: state.newsList));

      resultList = await newsRepository.getNews();

      _log.i('$TopNewsLoaded emitted');
      emit(TopNewsLoaded(newsList: resultList));
    });

    on<GetSearchNewsEvent>((event, emit) async {
      _log
        ..i('$GetSearchNewsEvent called')
        ..i('$NewsLoading emitted');
      emit(NewsLoading(newsList: state.newsList));

      resultList = await newsRepository.searchNews(
        searchPattern: event.searchQuery,
      );

      _log.i('$SearchNewsLoaded emitted');
      emit(SearchNewsLoaded(newsList: resultList));
    });

    on<ClearResultsEvent>((event, emit) {
      _log
        ..i('$ClearResultsEvent called')
        ..i('$NewsInitial emitted');

      emit(const NewsInitial());
    });
  }

  /// Authorization Firebase handler
  final NewsRepository newsRepository;

  /// Log style customizer
  final Logger _log = logger(NewsBloc);
}
