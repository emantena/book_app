/// Interface para serviço de analytics
abstract class IAnalyticsService {
  Future<void> logEvent(String name, Map<String, dynamic> parameters);
  Future<void> setUserId(String userId);
}