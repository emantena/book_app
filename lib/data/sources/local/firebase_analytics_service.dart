import '../../../domain/interfaces/services/i_analytics_service.dart';

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
