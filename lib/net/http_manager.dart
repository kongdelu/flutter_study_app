import 'package:dio/dio.dart';
import 'package:flutter_study_app/config/app_config.dart';
import 'package:flutter_study_app/config/urls.dart';
import 'dart:async';

import 'request_interceptors.dart';
import 'response_interceptors.dart';

/*
 * 封装 restful 请求
 *
 * GET、POST、DELETE、PATCH
 * 主要作用为统一处理相关事务：
 *  - 统一处理请求前缀；
 *  - 统一打印请求信息；
 *  - 统一打印响应信息；
 *  - 统一打印报错信息；
 */
class ApiManager {

  /// default options
  static const String API_PREFIX = AppConfig.isProduction?Urls.BASE_RELEASE_URL:Urls.BASE_DEBUG_URL;

  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  static Dio _dio;

  /// 创建 dio 实例对象
  static Dio sharedInstance () {
    if (_dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = new BaseOptions(
        baseUrl: API_PREFIX,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );

      _dio = new Dio(options);
      _dio.interceptors.add(new RequestInterceptors());
      _dio.interceptors.add(new ResponseInterceptors());
    }

    return _dio;
  }

  static Future<String> request (String url, { data, method }) async {

    data = data ?? {};
    method = method ?? 'GET';

    data.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    var result;
    Dio dio = sharedInstance();
    try {
      Response response = await dio.request(url, data: data, options: new Options(method: method));
      result = response.data;
      print('响应数据：' + response.toString());
    } on DioError catch (e) {
      print('请求出错：' + e.toString());
    }
    return result;
  }

  /// 清空 dio 对象
  static clear () {
    _dio = null;
  }
}