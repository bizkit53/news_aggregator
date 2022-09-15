/// Helper class to choose environment on startup to load right config file
abstract class Environment {
  /// Variable indicating app running in development mode
  static const dev = 'dev';

  /// Variable indicating app running in production mode
  static const prod = 'prod';
}
