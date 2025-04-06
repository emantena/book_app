// lib/core/utils/environment_config.dart
class EnvironmentConfig {
  // API keys e valores de configuração
  final String apiKey = const String.fromEnvironment('API_KEY', defaultValue: '');
  
  // URLs base para APIs
  final String booksApiBaseUrl = 'https://www.googleapis.com/books/v1/volumes';
  
  // Feature flags
  final bool enableAnalytics = true;
  final bool enableCrashReporting = true;
}