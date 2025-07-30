import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/config/res/app_sizes.dart';
import 'package:flutter_base/src/config/res/constants_manager.dart';
import 'package:flutter_base/src/core/widgets/offline_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/themes/app_theme.dart';
import 'core/helpers/loading_manager.dart';
import 'core/navigation/navigator.dart';
import 'core/navigation/route_generator.dart';
import 'core/shared/cubits/user_cubit/user_cubit.dart';
import 'core/shared/route_observer.dart';
import 'features/chat/presentation/cubit/chage_chat_attributes_cubit/chage_chat_attributes_cubit.dart';
import 'features/chat/presentation/cubit/timer_cubit/timer_cubit.dart';
import 'features/chat/presentation/pages/chat_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(ScreenSizes.width, ScreenSizes.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (ctx, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<UserCubit>(),
            ),
            BlocProvider(
              create: (context) => sl<ChageChatAttributesCubit>(),
            ),
            BlocProvider(
              create: (context) => sl<TimerCubit>(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: ConstantManager.projectName,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            navigatorKey: Go.navigatorKey,
            onGenerateRoute: RouterGenerator.getRoute,
            home: const ChatScreen(),
            navigatorObservers: [AppNavigationObserver()],
            theme: AppTheme.light,
            builder: (context, child) {
              return OfflineWidget(
                child: FullScreenLoadingManager(child: child!),
              );
            },
          ),
        );
      },
    );
  }
}
