import 'package:logger/logger.dart';

logger(Type type) => Logger(
      printer: CustomPrinter(
        className: type.toString(),
      ),
    );

class CustomPrinter extends LogPrinter {
  final String className;

  CustomPrinter({
    required this.className,
  });

  @override
  List<String> log(LogEvent event) {
    final AnsiColor? color = PrettyPrinter.levelColors[event.level];
    final String? emoji = PrettyPrinter.levelEmojis[event.level];
    final String? message = event.message;

    return [color!('$emoji $className: $message')];
  }
}
