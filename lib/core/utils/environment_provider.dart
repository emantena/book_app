// lib/core/utils/environment_provider.dart
import 'package:book_app/core/utils/environment_config.dart';

/// Enum representing different app environments
enum AppEnvironment {
  /// Development environment
  dev,
  
  /// Production environment
  prod,
  
  /// Testing environment
  test
}

/// Provider for environment-specific configuration
class EnvironmentProvider {
  /// The current environment
  static late AppEnvironment _environment;
  
  /// Initialize the environment provider
  static void init({required AppEnvironment environment}) {
    _environment = environment;
  }
  
  /// Get the current environment
  static AppEnvironment get environment => _environment;
  
  /// Check if the app is running in development mode
  static bool get isDevelopment => _environment == AppEnvironment.dev;
  
  /// Check if the app is running in production mode
  static bool get isProduction => _environment == AppEnvironment.prod;
  
  /// Check if the app is running in test mode
  static bool get isTest => _environment == AppEnvironment.test;
  
  /// Get the appropriate environment configuration
  static EnvironmentConfig getConfig() {
    switch (_environment) {
      case AppEnvironment.dev:
        return DevEnvironmentConfig();
      case AppEnvironment.prod:
        return ProdEnvironmentConfig();
      case AppEnvironment.test:
        return TestEnvironmentConfig();
    }
  }
}

/// Development environment configuration
class DevEnvironmentConfig extends EnvironmentConfig {
  @override
  String get apiKey => 'dev_api_key'; // For dev environment

  @override
  bool get enableAnalytics => false; // Disable analytics in dev
  
  @override
  bool get enableCrashReporting => false; // Disable crash reporting in dev
}

/// Production environment configuration
class ProdEnvironmentConfig extends EnvironmentConfig {
  // Production uses the default environment values
}

/// Test environment configuration
class TestEnvironmentConfig extends EnvironmentConfig {
  @override
  String get apiKey => 'test_api_key';  // Test API key
  
  @override
  bool get enableAnalytics => false;  // Disable analytics in test
  
  @override
  bool get enableCrashReporting => false;  // Disable crash reporting in test
}