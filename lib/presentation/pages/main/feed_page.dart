import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/import_constants.dart';
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
  List<News> newsList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SearchBar(),
            if (newsList.isEmpty)
              const CircularProgressIndicator()
            else
              ListView.separated(
                shrinkWrap: true,
                itemCount: newsList.length,
                itemBuilder: (context, index) => NewsTile(
                  news: newsList[index],
                ),
                separatorBuilder: (context, index) => Divider(
                  height: dividerHeight,
                  thickness: dividerThickness,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
