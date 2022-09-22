import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_aggregator/constans/environment.dart';
import 'package:news_aggregator/constans/responsive_breakpoints.dart';
import 'package:news_aggregator/constans/routes.dart';
import 'package:news_aggregator/firebase_options.dart';
import 'package:news_aggregator/logic/services/config_reader/config_reader.dart';
import 'package:news_aggregator/logic/utils/injector.dart';
import 'package:news_aggregator/logic/utils/route_generator.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: splashRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
      builder: (context, child) {
        return ResponsiveWrapper.builder(
          // Device preview is for quick check app look on diffrent screens
          DevicePreview.appBuilder(context, child),
          defaultScale: true,
          breakpoints: responsiveBreakpoints,
        );
      },
    );
  }
}
