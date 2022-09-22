import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Helper for AppLocalizations and its translation capabilities
extension LocalizedBuildContext on BuildContext {
  /// Getter shortcut for easier access to translations
  AppLocalizations get loc => AppLocalizations.of(this);
}
