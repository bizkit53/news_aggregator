// ignore_for_file: public_member_api_docs

part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState({this.newsList = const []});

  final List<News> newsList;

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {
  const NewsInitial();
}

class NewsLoading extends NewsState {
  const NewsLoading({required super.newsList});
}

class TopNewsLoaded extends NewsState {
  const TopNewsLoaded({required super.newsList});
}

class SearchNewsLoaded extends NewsState {
  const SearchNewsLoaded({required super.newsList});
}
