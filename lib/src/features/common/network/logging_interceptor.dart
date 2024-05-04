import 'package:dio/dio.dart';
import 'package:logging/logging.dart';


final _logger = Logger("API_Logging");
class LoggingInterceptor extends InterceptorsWrapper {
  final level =
      Level.INFO; // Customize logging level (INFO, WARNING, ERROR, etc.)

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _log(Level.INFO, '--> ${options.method} ${options.uri}');
    _log(Level.INFO, options.headers.toString());
    if (options.data != null) {
      _log(Level.INFO, options.data.toString());
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _log(Level.INFO,
        '<-- ${response.statusCode} ${response.requestOptions.uri}');
    _log(Level.INFO, response.headers.toString());
    if (response.data != null) {
      _log(Level.INFO, response.data.toString());
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log(Level.SEVERE, '${err.type}: ${err.message}');
    super.onError(err, handler);
  }

  void _log(Level level, String message) {
    // Implement your logging logic here:
    // - Use `print` for basic logging
    // - Use a logging package (like `logging` or `logger`) for structured logging & filtering
    print('[$level] - $message');
    
    _logger.fine('[$level] - $message');
  }
}
