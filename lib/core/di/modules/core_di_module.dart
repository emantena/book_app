import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/app_constants.dart';
import '../../config/environment_config.dart';
import '../../config/environment_provider.dart';
import '../../network/network_info.dart';
import '../../storage/cache_client.dart';
import '../../ui/app_router.dart';

class CoreDiModule {
  static Future<void> init(GetIt sl) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => Connectivity());

    sl.registerLazySingleton<EnvironmentConfig>(() => EnvironmentProvider.getConfig());

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

//TODO remover para um arquivo separado
/// Interface para serviço de analytics
abstract class IAnalyticsService {
  Future<void> logEvent(String name, Map<String, dynamic> parameters);
  Future<void> setUserId(String userId);
}

/// Implementação do Firebase Analytics
class FirebaseAnalyticsService implements IAnalyticsService {
  @override
  Future<void> logEvent(String name, Map<String, dynamic> parameters) async {
    // Implementação real do Firebase Analytics
  }

  @override
  Future<void> setUserId(String userId) async {
    // Implementação real do Firebase Analytics
  }
}

/// Implementação sem operações para dev/test
class NoOpAnalyticsService implements IAnalyticsService {
  @override
  Future<void> logEvent(String name, Map<String, dynamic> parameters) async {
    // Não faz nada
  }

  @override
  Future<void> setUserId(String userId) async {
    // Não faz nada
  }
}
