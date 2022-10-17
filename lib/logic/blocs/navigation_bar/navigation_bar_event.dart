// ignore_for_file: public_member_api_docs

part of 'navigation_bar_bloc.dart';

abstract class NavigationBarEvent extends Equatable {
  const NavigationBarEvent();

  @override
  List<Object> get props => [];
}

class IndexChangedEvent extends NavigationBarEvent {
  const IndexChangedEvent({required this.index});
  final int index;

  @override
  List<Object> get props => [index];
}
