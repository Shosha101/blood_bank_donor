import 'package:dio/dio.dart';

/// Outside the browser, cookies are handled by the cookie jar, so there is nothing to enable.
void enableBrowserCredentials(Dio dio) {}
