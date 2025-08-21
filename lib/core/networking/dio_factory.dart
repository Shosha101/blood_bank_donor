import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart'
    if (dart.library.html) 'package:path_provider/path_provider.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;
  static CookieJar? cookieJar;

  static Future<Dio> getDio({bool useCorsProxy = false}) async {
    const Duration timeOut = Duration(seconds: 30);

    if (dio == null) {
      final tempDio = Dio();
      try {
        tempDio.options
          ..baseUrl = useCorsProxy
              ? 'https://cors-anywhere.herokuapp.com/https://hemolink.runasp.net/api'
              : 'https://hemolink.runasp.net/api' // تغيير http إلى https
          ..connectTimeout = timeOut
          ..receiveTimeout = timeOut
          ..headers = {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            // ضيف هيدرز إضافية لو السيرفر بيطلبها
          }
          ..receiveDataWhenStatusError = true;

        if (!kIsWeb) {
          cookieJar = await _initializeCookieJar();
          tempDio.interceptors.add(CookieManager(cookieJar!));
        } else {
          // For Flutter Web: cast to BrowserHttpClientAdapter
          final adapter = tempDio.httpClientAdapter;
          if (adapter is BrowserHttpClientAdapter) {
            adapter.withCredentials = true; // تفعيل الكوكيز في الويب
          }
        }

        addDioInterceptor(tempDio);
      } catch (e) {
        print('Error initializing Dio: $e');
        rethrow;
      }
      dio = tempDio;
    }

    return dio!;
  }

  static Future<CookieJar> _initializeCookieJar() async {
    final directory = await getApplicationDocumentsDirectory();
    return PersistCookieJar(
      ignoreExpires: false,
      storage: FileStorage("${directory.path}/cookies"),
    );
  }

  static void resetDio() {
    dio = null;
    cookieJar = null;
  }

  static void addDioInterceptor(Dio dioInstance) {
    dioInstance.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Sending request to: ${options.uri}');
          print('Headers: ${options.headers}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          final cookies = response.headers['set-cookie'];
          if (cookies != null) {
            print('Response cookies: $cookies');
          }
          handler.next(response);
        },
        onError: (DioError error, handler) {
          print('DioError: ${error.response?.statusCode} ${error.message}');
          print('Response: ${error.response}');
          handler.next(error);
        },
      ),
    );

    dioInstance.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        responseBody: true,
      ),
    );
  }
}