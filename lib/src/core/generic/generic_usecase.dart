import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../error/failure.dart';
import '../network/network_request.dart';
import 'generic_repository.dart';

class GenericUseCase {
  final GenericRepository repository;
  GenericUseCase({required this.repository});

  Future<Result<T, Failure>> call<T>({
    required GenericUseCaseParams<T> params,
  }) async {
    return await repository.request<T>(params: params);
  }
}

class GenericUseCaseParams<T> {
  final String path;
  final RequestMethod method;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? headers;
  final bool isFormData;
  final ProgressCallback? onSendProgress;
  final ProgressCallback? onReceiveProgress;
  final T Function(dynamic json)? mapper;
  GenericUseCaseParams({
    required this.path,
    required this.method,
    this.body,
    this.queryParameters,
    this.headers,
    this.isFormData = false,
    this.onSendProgress,
    this.onReceiveProgress,
    this.mapper,
  });
}
