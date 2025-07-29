import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/src/config/language/languages.dart';
import 'package:flutter_base/src/config/res/color_manager.dart';
import 'package:flutter_base/src/core/navigation/go.dart';
import 'package:flutter_base/src/core/network/backend_configuation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';
import 'src/app.dart';
import 'src/core/helpers/cache_service.dart';
import 'src/core/navigation/Constants/imports_constants.dart';
import 'src/core/navigation/page_router/implementation/imports_page_router.dart';
import 'src/core/navigation/page_router/imports_page_router_builder.dart';
import 'src/core/shared/bloc_observer.dart';
import 'src/core/shared/functions/setup_service_locators.dart';
import 'src/core/widgets/exeption_view.dart';

class CustomImageCache extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() {
    ImageCache imageCache = super.createImageCache();
    // Set your image cache size
    imageCache.maximumSizeBytes = 1024 * 1024 * 100; // 100 MB
    return imageCache;
  }
}

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kReleaseMode) {
    CustomImageCache();
  }
  await Future.wait(
    [
      EasyLocalization.ensureInitialized(),
      CacheStorage.init(),
      ScreenUtil.ensureScreenSize()
    ],
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  setUpServiceLocator();

  // await sl<PusherChannelsFlutter>().init(
  //   apiKey: 'e9082f996e7a08138753',
  //   cluster: 'ap2',
  // );
  // await sl<PusherChannelsFlutter>().connect();
  BackendConfiguation.setBackendType(BackendType.php);
  PageRouterBuilder().initAppRouter(
    config: PlatformConfig(
      android: CustomPageRouterCreator(
        parentTransition: TransitionType.fade,
        parentOptions: const FadeAnimationOptions(
          duration: Duration(milliseconds: 300),
        ),
      ),
    ),
  );
  if (kReleaseMode) {
    ErrorWidget.builder =
        (FlutterErrorDetails details) => const ExceptionView();
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primary, // status bar color
  ));
  runApp(
    EasyLocalization(
      supportedLocales: Languages.suppoerLocales,
      path: 'assets/translations',
      saveLocale: true,
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: const App(),
    ),
  );
}
