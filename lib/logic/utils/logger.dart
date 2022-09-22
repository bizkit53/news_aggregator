import 'package:logger/logger.dart';

/// A function returning object for making customized logs
Logger logger(Type type) => Logger(
      printer: CustomPrinter(
        className: type.toString(),
      ),
    );

/// Log printing style definition
class CustomPrinter extends LogPrinter {
  /// Constructor
  CustomPrinter({
    required this.className,
  });

  /// Name of a class in which logger was called
  final String className;

  @override
  List<String> log(LogEvent event) {
    final AnsiColor? color = PrettyPrinter.levelColors[event.level];
    final String? emoji = PrettyPrinter.levelEmojis[event.level];
    final dynamic message = event.message;

    return [color!('$emoji $className: $message')];
  }
}
