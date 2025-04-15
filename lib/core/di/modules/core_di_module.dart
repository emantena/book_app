import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/sources/local/firebase_analytics_service.dart';
import '../../../data/sources/local/no_op_analytics_service.dart';
import '../../../domain/interfaces/services/i_analytics_service.dart';
import '../../config/app_constants.dart';
import '../../config/environment_config.dart';
import '../../config/environment_provider.dart';
import '../../network/network_info.dart';
import '../../storage/cache_client.dart';
import '../../ui/routes/app_router.dart';

class CoreDiModule {
  static Future<void> init(GetIt sl) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => Connectivity());

    sl.registerLazySingleton<EnvironmentConfig>(
        () => EnvironmentProvider.getConfig());

    sl.registerLazySingleton(() => CacheClient());

    sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl()));

    sl.registerLazySingleton(() => AppConstants());

    sl.registerLazySingleton(() => AppRouter(sl));

    final config = EnvironmentProvider.getConfig();
    if (config.enableAnalytics) {
      sl.registerLazySingleton<IAnalyticsService>(
        () => FirebaseAnalyticsService(),
      );
    } else {
      sl.registerLazySingleton<IAnalyticsService>(
        () => NoOpAnalyticsService(),
      );
    }
  }
}
