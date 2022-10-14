// ignore_for_file: public_member_api_docs

part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class GetTopNewsEvent extends NewsEvent {
  const GetTopNewsEvent();
}

class GetSearchNewsEvent extends NewsEvent {
  const GetSearchNewsEvent({required this.searchQuery});

  final String searchQuery;
}

class ClearResultsEvent extends NewsEvent {
  const ClearResultsEvent();
}
