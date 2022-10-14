import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/logic/blocs/news/news_bloc.dart';
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
  late List<News> newsList;
  bool canFetchData = false;

  @override
  void initState() {
    context.read<NewsBloc>().add(const ClearResultsEvent());
    context.read<NewsBloc>().add(const GetTopNewsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    newsList = context.watch<NewsBloc>().state.newsList;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                _logoImage(),
                const SearchBar(),
              ],
            ),
          ),
          _newsList(),
        ],
      ),
    );
  }

  SliverList _newsList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: newsList.length + 1,
        (context, index) {
          if (index == newsList.length && index < _newsLimit) {
            if (canFetchData) {
              canFetchData = false;
              context.read<NewsBloc>().add(const GetTopNewsEvent());
            }
            return _loader();
          }

          if (context.read<NewsBloc>().state is! NewsLoading) {
            canFetchData = true;
          }

          return _singleNewsTile(index);
        },
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
