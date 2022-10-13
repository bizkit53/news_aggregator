import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/models/news/news.dart';
import 'package:news_aggregator/presentation/widgets/import_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

/// Single news tile
class NewsTile extends StatelessWidget {
  /// Constructor
  const NewsTile({super.key, required this.news});

  /// News to display
  final News news;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingHor24Ver10,
      child: GestureDetector(
        onTap: () => _launchUrl(webUrl: news.url!),
        child: Container(
          decoration: customBoxDecoration(
            context: context,
            borderRadius: borderRadius,
          ),
          height: tileHeight,
          child: Column(
            children: [
              _image(),
              boxHeight10,
              _title(context),
              boxHeight5,
              _sourceAndBookmark(context),
              boxHeight10,
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _image() {
    return SizedBox(
      height: tileImageHeight,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: news.imageUrl!,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(Icons.error),
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Expanded _title(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: marginHorizontal10,
        child: Text(
          news.title!,
          style: Theme.of(context).textTheme.headline6,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Row _sourceAndBookmark(BuildContext context) {
    return Row(
      children: [
        boxWidth10,
        _newsSource(context),
        boxWidth10,
        _bookmarkButton(),
        boxWidth10,
      ],
    );
  }

  Expanded _newsSource(BuildContext context) {
    return Expanded(
      child: Text(
        '${news.source}',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  IconButton _bookmarkButton() {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: const Icon(Icons.bookmark_border),
      onPressed: () {
        // TODO(piotr-ciuba): Save news object
      },
    );
  }

  Future<void> _launchUrl({required String webUrl}) async {
    final Uri url = Uri.parse(webUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
