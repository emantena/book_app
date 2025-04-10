import '../../../domain/interfaces/services/i_analytics_service.dart';

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
