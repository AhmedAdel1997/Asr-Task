import 'package:flutter_base/src/core/network/dio_service.dart';
import 'package:flutter_base/src/core/network/network_service.dart';
import 'package:flutter_base/src/core/shared/cubits/user_cubit/user_cubit.dart';

import '../../../config/res/constants_manager.dart';
import '../../../features/chat/presentation/chat_di.dart';
import '../../generic/generic_remote_data_source.dart';
import '../../generic/generic_repository.dart';
import '../../generic/generic_usecase.dart';
import '../../notification/notification_service.dart';

void setUpServiceLocator() {
  setUpGeneralDependencies();
  setUpChatDependencies();
}

void setUpGeneralDependencies() {
  sl.registerLazySingleton<NetworkService>(
    () => DioService(),
  );

  sl.registerLazySingleton<UserCubit>(
    () => UserCubit(),
  );

  sl.registerFactory<NotificationService>(() => NotificationService());

  // Register a single generic instance for all generic API calls
  sl.registerLazySingleton<GenericRemoteDataSource>(
    () => GenericRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<GenericRepository>(
    () =>
        GenericRepositoryImpl(remoteDataSource: sl<GenericRemoteDataSource>()),
  );
  sl.registerLazySingleton<GenericUseCase>(
    () => GenericUseCase(repository: sl<GenericRepository>()),
  );
}
