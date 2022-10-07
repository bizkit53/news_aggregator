import 'package:flutter/material.dart';

/// Provides a helper for password and confirm password fields
class PasswordFieldHelper extends ChangeNotifier {
  /// Password visibility handler
  bool isHidden = true;

  /// Password field visibility controller
  void toggleVisibility() {
    isHidden = !isHidden;
    notifyListeners();
  }
}
