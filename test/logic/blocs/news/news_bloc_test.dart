import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_aggregator/logic/blocs/news/news_bloc.dart';
import 'package:news_aggregator/logic/repositories/news_repository.dart';
import 'package:news_aggregator/models/news/news.dart';

import 'news_bloc_test.mocks.dart';

@GenerateMocks([NewsRepository])
void main() {
  late MockNewsRepository mockNewsRepository;
  late String searchPattern;
  late String differentSearchPattern;
  late List<News> firstNewsList;
  late List<News> secondNewsList;
  late List<News> thirdNewsList;
  late List<List<News>> responses;
  late List<List<News>> differentPatternResponses;

  setUpAll(() {
    firstNewsList = [];
    secondNewsList = [];
    thirdNewsList = [];
    searchPattern = 'pattern';
    differentSearchPattern = 'differentPattern';

    for (int i = 0; i < 15; i++) {
      final News news = News(
        uuid: 'uuid$i',
        title: 'title$i',
        description: 'description$i',
        keywords: 'keyword$i',
        snippet: 'snippet$i',
        url: 'url$i',
        imageUrl: 'imageUrl$i',
        language: 'language$i',
        publishedAt: DateTime.now(),
        source: 'source$i',
        categories: ['category$i'],
        relevanceScore: 12.2,
        locale: 'locale$i',
      );
      if (i < 5) firstNewsList.add(news);
      if (i < 10) secondNewsList.add(news);
      thirdNewsList.add(news);
    }
  });

  setUp(() async {
    responses = [firstNewsList, secondNewsList, thirdNewsList];
    differentPatternResponses = [firstNewsList, secondNewsList, thirdNewsList];
    mockNewsRepository = MockNewsRepository();

    when(mockNewsRepository.getNews())
        .thenAnswer((_) => Future.value(responses.removeAt(0)));
    when(mockNewsRepository.searchNews(searchPattern: searchPattern))
        .thenAnswer((_) => Future.value(responses.removeAt(0)));
    when(mockNewsRepository.searchNews(searchPattern: differentSearchPattern))
        .thenAnswer((_) => Future.value(differentPatternResponses.removeAt(0)));
  });

  test('initial state is correct', () {
    final NewsBloc newsBloc = NewsBloc(newsRepository: mockNewsRepository);
    expect(
      newsBloc.state,
      const NewsInitial(),
    );
    expect(newsBloc.state.newsList, const <News>[]);
  });

  group('NewsBloc - get top news:', () {
    blocTest<NewsBloc, NewsState>(
      'first call from initial state',
      build: () => NewsBloc(newsRepository: mockNewsRepository),
      act: (bloc) => bloc.add(const GetTopNewsEvent()),
      expect: () => <NewsState>[
        const NewsLoading(newsList: []),
        TopNewsLoaded(newsList: firstNewsList),
      ],
      verify: (_) => verify(mockNewsRepository.getNews()).called(1),
    );

    blocTest<NewsBloc, NewsState>(
      'triple call',
      build: () => NewsBloc(newsRepository: mockNewsRepository),
      act: (bloc) => bloc
        ..add(const GetTopNewsEvent())
        ..add(const GetTopNewsEvent())
        ..add(const GetTopNewsEvent()),
      expect: () => <NewsState>[
        const NewsLoading(newsList: []),
        TopNewsLoaded(newsList: firstNewsList),
        NewsLoading(newsList: firstNewsList),
        TopNewsLoaded(newsList: secondNewsList),
        NewsLoading(newsList: secondNewsList),
        TopNewsLoaded(newsList: thirdNewsList),
      ],
      verify: (_) => verify(mockNewsRepository.getNews()).called(3),
    );
  });

  group('NewsBloc - get search news:', () {
    blocTest<NewsBloc, NewsState>(
      'first call from initial state',
      build: () => NewsBloc(newsRepository: mockNewsRepository),
      act: (bloc) => bloc.add(GetSearchNewsEvent(searchQuery: searchPattern)),
      expect: () => <NewsState>[
        const NewsLoading(newsList: []),
        SearchNewsLoaded(newsList: firstNewsList),
      ],
      verify: (_) => verify(
        mockNewsRepository.searchNews(searchPattern: searchPattern),
      ).called(1),
    );

    blocTest<NewsBloc, NewsState>(
      'triple call',
      build: () => NewsBloc(newsRepository: mockNewsRepository),
      act: (bloc) => bloc
        ..add(GetSearchNewsEvent(searchQuery: searchPattern))
        ..add(GetSearchNewsEvent(searchQuery: searchPattern))
        ..add(GetSearchNewsEvent(searchQuery: searchPattern)),
      expect: () => <NewsState>[
        const NewsLoading(newsList: []),
        SearchNewsLoaded(newsList: firstNewsList),
        NewsLoading(newsList: firstNewsList),
        SearchNewsLoaded(newsList: secondNewsList),
        NewsLoading(newsList: secondNewsList),
        SearchNewsLoaded(newsList: thirdNewsList),
      ],
      verify: (_) => verify(
        mockNewsRepository.searchNews(searchPattern: searchPattern),
      ).called(3),
    );

    blocTest<NewsBloc, NewsState>(
      'triple call - last with different search patterns',
      build: () => NewsBloc(newsRepository: mockNewsRepository),
      act: (bloc) => bloc
        ..add(GetSearchNewsEvent(searchQuery: searchPattern))
        ..add(GetSearchNewsEvent(searchQuery: searchPattern))
        ..add(GetSearchNewsEvent(searchQuery: differentSearchPattern)),
      expect: () => <NewsState>[
        const NewsLoading(newsList: []),
        SearchNewsLoaded(newsList: firstNewsList),
        NewsLoading(newsList: firstNewsList),
        SearchNewsLoaded(newsList: secondNewsList),
        NewsLoading(newsList: secondNewsList),
        SearchNewsLoaded(newsList: firstNewsList),
      ],
      verify: (_) {
        verify(
          mockNewsRepository.searchNews(searchPattern: searchPattern),
        ).called(2);
        verify(
          mockNewsRepository.searchNews(searchPattern: differentSearchPattern),
        ).called(1);
      },
    );
  });

  group('NewsBloc - clear results:', () {
    blocTest<NewsBloc, NewsState>(
      'first call from initial state',
      build: () => NewsBloc(newsRepository: mockNewsRepository),
      act: (bloc) => bloc.add(const ClearResultsEvent()),
      expect: () => <NewsState>[
        const NewsInitial(),
      ],
    );

    blocTest<NewsBloc, NewsState>(
      'clearing results after top news loaded',
      build: () => NewsBloc(newsRepository: mockNewsRepository),
      act: (bloc) => bloc
        ..add(const GetTopNewsEvent())
        ..add(const ClearResultsEvent()),
      expect: () => <NewsState>[
        const NewsLoading(newsList: []),
        TopNewsLoaded(newsList: firstNewsList),
        const NewsInitial(),
      ],
    );

    blocTest<NewsBloc, NewsState>(
      'clearing results after search news loaded',
      build: () => NewsBloc(newsRepository: mockNewsRepository),
      act: (bloc) => bloc
        ..add(GetSearchNewsEvent(searchQuery: searchPattern))
        ..add(const ClearResultsEvent()),
      expect: () => <NewsState>[
        const NewsLoading(newsList: []),
        SearchNewsLoaded(newsList: firstNewsList),
        const NewsInitial(),
      ],
    );
  });
}
