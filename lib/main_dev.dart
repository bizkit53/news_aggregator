import 'package:news_aggregator/constans/environment.dart';
import 'package:news_aggregator/main.dart';

Future<void> main() async {
  await mainCommon(Environment.dev);
}
