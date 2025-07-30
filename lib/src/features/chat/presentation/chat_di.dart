import '../../../config/res/constants_manager.dart';
import 'cubit/chage_chat_attributes_cubit/chage_chat_attributes_cubit.dart';
import 'cubit/download_record_cubit/download_record_cubit.dart';
import 'cubit/get_chat_messages_cubit/get_chat_messages_cubit.dart';
import 'cubit/timer_cubit/timer_cubit.dart';

void setUpChatDependencies() {
  sl.registerFactory<ChageChatAttributesCubit>(
    () => ChageChatAttributesCubit(),
  );
  sl.registerFactory<DownloadRecordCubit>(
    () => DownloadRecordCubit(),
  );
  sl.registerFactory<GetChatMessagesCubit>(
    () => GetChatMessagesCubit(),
  );
  sl.registerLazySingleton<TimerCubit>(
    () => TimerCubit(),
  );
}
