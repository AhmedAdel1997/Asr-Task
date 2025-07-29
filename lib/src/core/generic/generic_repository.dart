import 'package:multiple_result/multiple_result.dart';

import '../error/failure.dart';
import '../extensions/error_handler_extension.dart';
import 'generic_remote_data_source.dart';
import 'generic_usecase.dart';

abstract class GenericRepository {
  Future<Result<T, Failure>> request<T>({
    required GenericUseCaseParams<T> params,
  });
}

class GenericRepositoryImpl implements GenericRepository {
  final GenericRemoteDataSource remoteDataSource;
  GenericRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<T, Failure>> request<T>({
    required GenericUseCaseParams<T> params,
  }) async {
    return await remoteDataSource
        .request<T>(params: params)
        .handleCallbackWithFailure();
  }
}
