import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_aggregator/constans/import_constants.dart';
import 'package:news_aggregator/presentation/widgets/import_widgets.dart';

/// Button for login with google
class GoogleLoginButton extends StatelessWidget {
  /// Constructor
  const GoogleLoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomWideButton(
      child: Transform.scale(
        scale: 0.75.r,
        child: Image.asset(
          googleLogoTransparentPath,
        ),
        // TODO(bizkit53): implement onPressed google login
      ),
    );
  }
}
