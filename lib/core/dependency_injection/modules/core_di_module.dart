import 'package:book_app/core/network/network_info.dart';
import 'package:book_app/core/resources/app_constants.dart';
import 'package:book_app/core/routes/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:book_app/core/cache/cache_client.dart';
import 'package:book_app/core/utils/environment_config.dart';
import 'package:book_app/core/utils/environment_provider.dart';

/// Módulo para dependências do núcleo da aplicação
class CoreDiModule {
  /// Inicializar dependências do core
  static Future<void> init(GetIt sl) async {
    // Dependências externas
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => Connectivity());

    // Configuração de ambiente
    sl.registerLazySingleton<EnvironmentConfig>(
        () => EnvironmentProvider.getConfig());

    // Cache
    sl.registerLazySingleton(() => CacheClient());

    // Info de rede
    sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl()));

    // Constantes da aplicação
    sl.registerLazySingleton(() => AppConstants());

    // Router
    sl.registerLazySingleton(() => AppRouter(sl));

    // Analytics - com base no ambiente
    final config = EnvironmentProvider.getConfig();
    if (config.enableAnalytics) {
      sl.registerLazySingleton<IAnalyticsService>(
        () => FirebaseAnalyticsService(),
      );
    } else {
      // Versão mock para dev/teste
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
