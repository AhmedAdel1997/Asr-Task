import '../../config/res/constants_manager.dart';
import '../network/network_request.dart';
import '../network/network_service.dart';
import 'generic_usecase.dart';

abstract class GenericRemoteDataSource {
  Future<T> request<T>({
    required GenericUseCaseParams<T> params,
  });
}

class GenericRemoteDataSourceImpl implements GenericRemoteDataSource {
  GenericRemoteDataSourceImpl();

  @override
  Future<T> request<T>({
    required GenericUseCaseParams<T> params,
  }) async {
    final NetworkRequest request = NetworkRequest(
      path: params.path,
      method: params.method,
      body: params.body,
      queryParameters: params.queryParameters,
      headers: params.headers,
      isFormData: params.isFormData,
      onSendProgress: params.onSendProgress,
      onReceiveProgress: params.onReceiveProgress,
    );
    final response =
        await sl<NetworkService>().callApi(request, mapper: params.mapper);
    return response.data;
  }
}
