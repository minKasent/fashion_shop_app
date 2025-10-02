import 'package:fashion_shop/core/logging/app_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@LazySingleton(as: AppLogger)
class ConsoleAppLogger implements AppLogger {
  final Logger _logger;

  ConsoleAppLogger() : _logger = Logger(level: Level.trace, printer: PrettyPrinter(methodCount: 1, errorMethodCount: 5, lineLength: 90));

  @override
  void crash({String reason = '', Object? error, StackTrace? stackTrace, Map<String, dynamic>? meta}) {
    _logger.e(_mix('CRASH: $reason', meta), error: error, stackTrace: stackTrace);
  }

  @override
  void d(Object message, {Object? error, StackTrace? stackTrace, Map<String, dynamic>? meta}) {
    _logger.d(_mix(message, meta), error: error, stackTrace: stackTrace);
  }

  @override
  void e(Object message, {Object? error, StackTrace? stackTrace, Map<String, dynamic>? meta}) {
    _logger.e(_mix(message, meta), error: error, stackTrace: stackTrace);
  }

  @override
  void f(Object message, {Object? error, StackTrace? stackTrace, Map<String, dynamic>? meta}) {
    _logger.f(_mix(message, meta), error: error, stackTrace: stackTrace);
  }

  @override
  void i(Object message, {Object? error, StackTrace? stackTrace, Map<String, dynamic>? meta}) {
    _logger.w(_mix(message, meta), error: error, stackTrace: stackTrace);
  }

  @override
  void t(Object message, {Object? error, StackTrace? stackTrace, Map<String, dynamic>? meta}) {
    _logger.t(_mix(message, meta), error: error, stackTrace: stackTrace);
  }

  @override
  void w(Object message, {Object? error, StackTrace? stackTrace, Map<String, dynamic>? meta}) {
    _logger.w(_mix(message, meta), error: error, stackTrace: stackTrace);
  }

  String _mix(Object msg, Map<String, dynamic>? meta) => meta == null ? '$msg' : '$msg | meta=$meta';
}
