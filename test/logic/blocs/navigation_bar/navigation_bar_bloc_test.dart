import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_aggregator/logic/blocs/navigation_bar/navigation_bar_bloc.dart';

void main() {
  test('initial state is correct', () {
    expect(
      NavigationBarBloc().state,
      NavigationBarInitial(),
    );
    expect(NavigationBarBloc().state.selectedIndex, 0);
  });

  blocTest<NavigationBarBloc, NavigationBarState>(
    'single event',
    build: NavigationBarBloc.new,
    act: (bloc) => bloc.add(const IndexChangedEvent(index: 1)),
    expect: () => <NavigationBarState>[
      const NavigationBarChanged(selectedIndex: 1),
    ],
  );

  blocTest<NavigationBarBloc, NavigationBarState>(
    'multiple events',
    build: NavigationBarBloc.new,
    act: (bloc) {
      bloc
        ..add(const IndexChangedEvent(index: 1))
        ..add(const IndexChangedEvent(index: 2))
        ..add(const IndexChangedEvent(index: 3));
    },
    expect: () => <NavigationBarState>[
      const NavigationBarChanged(selectedIndex: 1),
      const NavigationBarChanged(selectedIndex: 2),
      const NavigationBarChanged(selectedIndex: 3),
    ],
  );
}
