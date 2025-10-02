/// Base app logger
abstract class AppLogger {
  /// Log a message at level [Level.debug]
  void d(Object message, {Object? error, StackTrace? stackTrace, Map<String, dynamic>? meta});

  /// Log a message at level [Level.info]
  void i(Object message, {Object? error, StackTrace? stackTrace, Map<String, dynamic>? meta});

  /// Log a message at level [Level.warning]
  void w(Object message, {Object? error, StackTrace? stackTrace, Map<String, dynamic>? meta});

  /// Log a message at level [Level.error]
  void e(Object message, {Object? error, StackTrace? stackTrace, Map<String, dynamic>? meta});

  /// Log a message at level [Level.trace]
  void t(Object message, {Object? error, StackTrace? stackTrace, Map<String, dynamic>? meta});

  /// Log a message at level [Level.fatal]
  void f(Object message, {Object? error, StackTrace? stackTrace, Map<String, dynamic>? meta});

  /// Log a message at level [Level.error]
  void crash({String reason = '', Object? error, StackTrace? stackTrace, Map<String, dynamic>? meta});
}
