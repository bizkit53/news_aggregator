import 'package:responsive_framework/responsive_framework.dart';

/// Width breakpoints at which app should change its UI drawing behaviour
const List<ResponsiveBreakpoint> responsiveBreakpoints = [
  ResponsiveBreakpoint.resize(350, name: MOBILE),
  ResponsiveBreakpoint.autoScale(600, name: TABLET),
  ResponsiveBreakpoint.resize(800, name: DESKTOP),
  ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
];
