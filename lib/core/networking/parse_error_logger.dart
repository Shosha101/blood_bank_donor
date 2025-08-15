// lib/core/networking/parse_error_logger.dart



import 'package:blood_bank_donor/core/networking/api_error_handler.dart';

class ParseErrorLogger {
  void logError(Exception error, StackTrace stackTrace) {
    // Integrate with your existing error-handling system
    final errorHandler = ErrorHandler.handle(error);
    final apiErrorModel = errorHandler.apiErrorModel;
    print('Error: ${apiErrorModel.message} (Code: ${apiErrorModel.code})');
    // Optionally, integrate with a logging service (e.g., Sentry, Firebase Crashlytics)
  }
}