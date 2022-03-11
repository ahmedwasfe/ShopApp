import 'package:dio/dio.dart';

class DioHelper {
  static Dio? _dio;
  static Dio? _dioShop;

  static initTodoApp() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        headers: {'Content-Type': 'application/json'},
        connectTimeout: 5000,
        receiveTimeout: 3000,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getNewsData({
    required String pathUrl,
    required Map<String, dynamic> query,
  }) async {
    return await _dio!.get(pathUrl,
        options: Options(
          receiveTimeout: 3000,
        ),
        queryParameters: query);
  }

  //////////////////////////////////////////////////////////////////////////////////////////
  // SHOP APP

  static initShopApp() {
    _dioShop = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        connectTimeout: 8000,
        receiveTimeout: 3000,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getShopData({
    required String pathUrl,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    _dioShop!.options.headers = {
      'Content-Type': 'application/json',
      'lang': '$lang',
      'Authorization': '$token',
    };
    return await _dioShop!.get(pathUrl,
        options: Options(
          receiveTimeout: 3000,
        ),
        queryParameters: query);
  }

  static Future<Response> postShopData({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    _dioShop!.options.contentType = Headers.jsonContentType;
    _dioShop!.options.headers = {
      'Content-Type': 'application/json',
      'lang': '$lang',
      'Authorization': '$token',
    };
    return await _dioShop!.post(endPoint,
        data: data,
        queryParameters: query,
        options: Options(
          receiveTimeout: 3000,
        ));
  }

  static Future<Response> putShopData({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    _dioShop!.options.contentType = Headers.jsonContentType;
    _dioShop!.options.headers = {
      'Content-Type': 'application/json',
      'lang': '$lang',
      'Authorization': '$token',
    };
    return await _dioShop!.put(endPoint,
        data: data,
        queryParameters: query,
        options: Options(
          receiveTimeout: 3000,
        ));
  }

  static Future<Response> signUpUser(Map<String, dynamic> data) async {
    Dio _dio = new Dio();
    _dio.options.contentType = Headers.formUrlEncodedContentType;

    return await _dio
        .post('https://student.valuxapps.com/api/register', data: data);
  }
}
