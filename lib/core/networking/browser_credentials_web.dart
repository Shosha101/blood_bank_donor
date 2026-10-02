import 'package:dio/browser.dart';
import 'package:dio/dio.dart';

/// In the browser, lets requests carry the session cookie.
void enableBrowserCredentials(Dio dio) {
  final adapter = dio.httpClientAdapter;
  if (adapter is BrowserHttpClientAdapter) {
    adapter.withCredentials = true; // تفعيل الكوكيز في الويب
  }
}
