import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:web_scraper/web_scraper.dart';

class HttpConnection {
  static final dio = Dio();
  static final cookieJar = CookieJar();
  static final webScraper = WebScraper();

  static void Configure() async {
    dio.interceptors.add(CookieManager(cookieJar));

    // Set default request headers
    dio.options.headers['Connection'] = 'keep-alive';
    dio.options.headers['Host'] = 'sigaa.ufrrj.br';
    dio.options.headers['User-Agent'] =
        'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36';
    dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    dio.options.followRedirects = false; // It is imporant to follow redirects
    dio.options.maxRedirects = 20;
    dio.options.validateStatus = (status) {
      return status! < 500;
    };
  }
}
