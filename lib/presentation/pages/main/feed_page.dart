import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/logic/repositories/news_repository.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';
import 'package:news_aggregator/models/news/news.dart';
import 'package:news_aggregator/presentation/widgets/import_widgets.dart';

/// Page with latest news tiles
class FeedPage extends StatefulWidget {
  /// Constructor
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final int _newsLimit = 30;
  List<News> newsList = [];

  Future<void> _fetchTopNews() async {
    newsList = await locator.get<NewsRepository>().getNews();
    setState(() {});
  }

  @override
  void initState() {
    _fetchTopNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                _logoImage(),
                const SearchBar(),
                if (newsList.isEmpty) _loader(),
              ],
            ),
          ),
          if (newsList.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: newsList.length + 1,
                (context, index) {
                  if (index == newsList.length && index < _newsLimit) {
                    _fetchTopNews();
                    return _loader();
                  }
                  return _singleNewsTile(index);
                },
              ),
            ),
        ],
      ),
    );
  }

  Wrap _singleNewsTile(int index) {
    return Wrap(
      children: [
        NewsTile(
          news: newsList[index],
        ),
        Divider(
          height: dividerHeight,
          thickness: dividerThickness,
        ),
      ],
    );
  }

  Transform _logoImage() {
    return Transform.scale(
      scale: smallImageScale,
      child: Image.asset(
        logoTransparentNoTextPath,
        height: mediumImageSquareSize,
        width: mediumImageSquareSize,
      ),
    );
  }

  Padding _loader() {
    return Padding(
      padding: loaderPadding,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
