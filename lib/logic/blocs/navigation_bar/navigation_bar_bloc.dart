import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:news_aggregator/logic/utils/import_utils.dart';

part 'navigation_bar_event.dart';
part 'navigation_bar_state.dart';

/// Helper for navigation bar
class NavigationBarBloc extends Bloc<NavigationBarEvent, NavigationBarState> {
  /// Constructor
  NavigationBarBloc() : super(NavigationBarInitial()) {
    on<IndexChangedEvent>((event, emit) {
      _log.i('$IndexChangedEvent called');
      emit(NavigationBarChanged(selectedIndex: event.index));
      _log.i('$NavigationBarChanged emitted');
    });
  }

  /// Log style customizer
  final Logger _log = logger(NavigationBarBloc);
}
