// ignore_for_file: public_member_api_docs

part of 'navigation_bar_bloc.dart';

abstract class NavigationBarState extends Equatable {
  const NavigationBarState({
    this.selectedIndex = 0,
  });

  final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
}

class NavigationBarInitial extends NavigationBarState {}

class NavigationBarChanged extends NavigationBarState {
  const NavigationBarChanged({
    required super.selectedIndex,
  });
}
