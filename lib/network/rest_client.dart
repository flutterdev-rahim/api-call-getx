import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_api_call/network/catch.dart';
import 'package:getx_api_call/network/custom_exception.dart';
import 'package:getx_api_call/network/end_point.dart';
import 'package:getx_api_call/network/logger.dart';
import 'package:getx_api_call/network/pritty_dio_logger.dart';

class RestClient {
  late Dio _dio;
  final connectionTimeout = 30000;
  final receiveTimeout = 30000;

  RestClient() {
    BaseOptions options = BaseOptions(
      baseUrl: API.dev,
      connectTimeout: connectionTimeout,
      receiveTimeout: receiveTimeout,
    );
    _dio = Dio(options);
  }

  RestClient.dev() {
    BaseOptions options = BaseOptions(
      baseUrl: API.dev,
      connectTimeout: connectionTimeout,
      receiveTimeout: receiveTimeout,
    );
    _dio = Dio(options);
  }

  Future<Response<dynamic>> get(
    APIType apiType,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);

    return _dio
        .get(path, queryParameters: data, options: standardHeaders)
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> post(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .post(
          path,
          data: data,
          options: standardHeaders,
          queryParameters: queryParams,
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  /// Supports media upload
  Future<Response<dynamic>> postFormData(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll({
        'Content-Type': 'multipart/form-data',
      });
    }

    return _dio
        .post(
          path,
          data: FormData.fromMap(data),
          options: standardHeaders,
          queryParameters: queryParams,
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> put(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .put(
          path,
          data: data,
          options: standardHeaders,
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  /// Supports media upload
  Future<Response<dynamic>> putFormData(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll({
        'Content-Type': 'multipart/form-data',
      });
    }
    data.addAll({
      '_method': 'PUT',
    });

    return _dio
        .post(
          path,
          data: FormData.fromMap(data),
          options: standardHeaders,
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  dynamic _getDioException(error) {
    if (error is DioError) {
      Log.error(
          'DIO ERROR: ${error.type} ENDPOINT: ${error.requestOptions.baseUrl}${error.requestOptions.path}');
      switch (error.type) {
        case DioErrorType.cancel:
          throw RequestCancelledException(
              001, 'Something went wrong. Please try again.');
        case DioErrorType.connectTimeout:
          throw RequestTimeoutException(
              408, 'Could not connect to the server.');
        case DioErrorType.other:
          throw DefaultException(
              002, 'Something went wrong. Please try again.');
        case DioErrorType.receiveTimeout:
          throw ReceiveTimeoutException(
              004, 'Could not connect to the server.');
        case DioErrorType.sendTimeout:
          throw RequestTimeoutException(
              408, 'Could not connect to the server.');
        case DioErrorType.response:
          final errorMessage = error.response?.data['message'];
          switch (error.response?.statusCode) {
            case 400:
              // throw CustomException(400, jsonEncode(error.response?.data), ""); /// Before
              throw CustomException(400, error.response?.data["message"], "");
            case 403:
              final message = errorMessage ?? '${error.response?.data}';
              throw UnauthorisedException(error.response?.statusCode, message);
            case 401:
              final message = errorMessage ?? '${error.response?.data}';

              /// TODO: Handle un-authentication error
              // setBool(LOGGED_IN, false);
              // Navigate.toAndRemoveUntil(Fade(page: LoginScreen()));
              throw UnauthorisedException(error.response?.statusCode, message);
            case 404:
              throw NotFoundException(
                  404, errorMessage ?? error.response?.data.toString());
            case 409:
              throw ConflictException(
                  409, 'Something went wrong. Please try again.');
            case 408:
              throw RequestTimeoutException(
                  408, 'Could not connect to the server.');
            case 500:
              throw InternalServerException(
                  500, 'Something went wrong. Please try again.');
            default:
              throw DefaultException(0002,
                  errorMessage ?? 'Something went wrong. Please try again.');
          }
      }
    } else {
      throw UnexpectedException(000, 'Something went wrong. Please try again.');
    }
  }

  void _setDioInterceptorList() {
    List<Interceptor> interceptorList = [];
    _dio.interceptors.clear();

    if (kDebugMode) {
      interceptorList.add(PrettyDioLogger());
    }
    _dio.interceptors.addAll(interceptorList);
  }

  Future<Options> _getOptions(APIType api) async {
    final box = GetStorage('Auth');
    final apiToken = await box.read(CacheKeys.token);

    switch (api) {
      case APIType.PUBLIC:
        return PublicApiOptions().options;

      case APIType.PROTECTED:
        return ProtectedApiOptions(apiToken).options;

      default:
        return PublicApiOptions().options;
    }
  }
}

abstract class ApiOptions {
  Options options = Options();
}

enum APIType { PUBLIC, PROTECTED }

class PublicApiOptions extends ApiOptions {
  PublicApiOptions() {
    super.options.headers = <String, dynamic>{
      'Accept': 'application/json',
      'Content-type': 'application/json',
    };
  }
}

class ProtectedApiOptions extends ApiOptions {
  ProtectedApiOptions(String apiToken) {
    super.options.headers = <String, dynamic>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiToken',
    };
  }
}
