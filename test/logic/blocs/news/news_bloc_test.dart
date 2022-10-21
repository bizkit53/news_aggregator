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
  late List<News> firstNewsList;
  late List<News> secondNewsList;
  late List<News> thirdNewsList;
  late List<List<News>> responses;

  setUpAll(() {
    firstNewsList = [];
    secondNewsList = [];
    thirdNewsList = [];

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
    mockNewsRepository = MockNewsRepository();
    when(mockNewsRepository.getNews()).thenAnswer(
      (_) => Future.value(responses.removeAt(0)),
    );
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
}
