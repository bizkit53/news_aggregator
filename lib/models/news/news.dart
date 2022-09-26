// ignore_for_file: public_member_api_docs

import 'package:freezed_annotation/freezed_annotation.dart';

part 'news.freezed.dart';
part 'news.g.dart';

@freezed
class News with _$News {
  factory News({
    String? uuid,
    String? title,
    String? description,
    String? keywords,
    String? snippet,
    String? url,
    @JsonKey(name: 'image_url') String? imageUrl,
    String? language,
    @JsonKey(name: 'published_at') DateTime? publishedAt,
    String? source,
    List<String>? categories,
    @JsonKey(name: 'relevance_score') double? relevanceScore,
    String? locale,
  }) = _News;

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
}
