import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_aggregator/constans/routes.dart';
import 'package:news_aggregator/firebase_options.dart';
import 'logic/utils/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: splashRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
