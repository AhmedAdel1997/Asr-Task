import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/src/config/res/constants_manager.dart';
import 'package:flutter_base/src/core/network/extensions.dart';
import 'package:flutter_base/src/core/shared/base_model.dart';

import '../../config/language/languages.dart';
import '../../config/language/locale_keys.g.dart';
import '../error/exceptions.dart';
import 'log_interceptor.dart';
import 'network_request.dart';
import 'network_service.dart';

class DioService implements NetworkService {
  late final Dio _dio;

  DioService() {
    _initDio();
  }

  void _initDio() {
    _dio = Dio()
      ..options.baseUrl = ConstantManager.baseUrl
      ..options.connectTimeout = const Duration(
        seconds: ConstantManager.connectTimeoutDuration,
      )
      ..options.receiveTimeout = const Duration(
        seconds: ConstantManager.recieveTimeoutDuration,
      )
      ..options.responseType = ResponseType.json
      ..options.headers.addAll({
        "Accept": "application/json",
        "Accept-Language": Languages.currentLanguage.locale.languageCode
      });

    // if (BackendConfiguation.type.isPhp) {
    //   _dio.interceptors.add(ConfigurationInterceptor());
    // }
    if (kDebugMode) {
      _dio.interceptors.add(LoggerInterceptor());
    }
  }

  @override
  void setToken(String token) {
    _dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
  }

  @override
  void removeToken() {
    _dio.options.headers.remove(HttpHeaders.authorizationHeader);
  }

  @override
  Future<BaseModel<Model>> callApi<Model>(NetworkRequest networkRequest,
      {Model Function(dynamic json)? mapper}) async {
    try {
      await networkRequest.prepareRequestData();
      final response = await _dio.request(networkRequest.path,
          data: networkRequest.hasBodyAndProgress()
              ? networkRequest.isFormData
                  ? FormData.fromMap(networkRequest.body!)
                  : networkRequest.body
              : networkRequest.body,
          queryParameters: networkRequest.queryParameters,
          onSendProgress: networkRequest.hasBodyAndProgress()
              ? networkRequest.onSendProgress
              : null,
          onReceiveProgress: networkRequest.hasBodyAndProgress()
              ? networkRequest.onReceiveProgress
              : null,
          options: Options(
              method: networkRequest.asString(),
              headers: networkRequest.headers));
      if (mapper != null) {
        return BaseModel.fromJson(response.data, jsonToModel: mapper);
      } else {
        return BaseModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  String _getErrorMessage(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      // Check if errors field exists and is not empty
      if (responseData['errors'] != null &&
          responseData['errors'] is Map &&
          (responseData['errors'] as Map).isNotEmpty) {
        // Get the first error message from the first field
        final errors = responseData['errors'] as Map;
        final firstFieldErrors = errors.values.first;
        if (firstFieldErrors is List && firstFieldErrors.isNotEmpty) {
          return firstFieldErrors.first;
        }
      }
      // Fallback to message field
      return responseData['message'] ?? LocaleKeys.serverError;
    }
    return LocaleKeys.serverError;
  }

  dynamic _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NoInternetConnectionException(LocaleKeys.checkInternet);
      case DioExceptionType.badResponse:
        switch (error.response!.statusCode) {
          case HttpStatus.unprocessableEntity:
            throw UnauthorizedException(_getErrorMessage(error.response?.data));
          case HttpStatus.badRequest:
            throw BadRequestException(_getErrorMessage(error.response?.data));
          case HttpStatus.unauthorized:
            throw UnauthorizedException(_getErrorMessage(error.response?.data));
          case HttpStatus.locked:
            throw BlockedException(_getErrorMessage(error.response?.data));
          case HttpStatus.notFound:
            throw NotFoundException(LocaleKeys.notFound);
          case HttpStatus.conflict:
            throw ConflictException(_getErrorMessage(error.response?.data));
          case HttpStatus.internalServerError:
            throw InternalServerErrorException(
                _getErrorMessage(error.response?.data));
          default:
            throw ServerException(LocaleKeys.serverError);
        }
      case DioExceptionType.cancel:
        throw ServerException(LocaleKeys.intenetWeakness);
      case DioExceptionType.unknown:
        throw ServerException(_getErrorMessage(error.response?.data));
      default:
        throw ServerException(_getErrorMessage(error.response?.data));
    }
  }

  @override
  void setLanguage(String language) {
    _dio.options.headers["Accept-Language"] = language;
  }
}
