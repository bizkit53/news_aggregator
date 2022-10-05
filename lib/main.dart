import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_aggregator/constans/environment.dart';
import 'package:news_aggregator/constans/routes.dart';
import 'package:news_aggregator/firebase_options.dart';
import 'package:news_aggregator/logic/services/config_reader/config_reader.dart';
import 'package:news_aggregator/logic/utils/injector.dart';
import 'package:news_aggregator/logic/utils/route_generator.dart';

/// Setup everything depending on the environment
Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize(env);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  injectorSetup();
  runApp(
    DevicePreview(
      enabled: isDevicePreviewEnabled,
      builder: (context) => const MyApp(),
    ),
  );
}

/// Root of the app
class MyApp extends StatelessWidget {
  /// Constructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          initialRoute: welcomeRoute,
          onGenerateRoute: RouteGenerator.generateRoute,
          builder: DevicePreview.appBuilder,
        );
      },
    );
  }
}
