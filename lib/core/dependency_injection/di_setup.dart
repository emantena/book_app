// lib/core/dependency_injection/di_setup.dart
import 'package:get_it/get_it.dart';
import 'package:book_app/core/dependency_injection/modules/auth_di_module.dart';
import 'package:book_app/core/dependency_injection/modules/book_di_module.dart';
import 'package:book_app/core/dependency_injection/modules/profile_di_module.dart';
import 'package:book_app/core/dependency_injection/modules/search_di_module.dart';
import 'package:book_app/core/dependency_injection/modules/firebase_di_module.dart';
import 'package:book_app/core/dependency_injection/modules/core_di_module.dart';

/// Global service locator instance
final sl = GetIt.instance;

/// Initializes all dependency injection modules
Future<void> initializeDependencies() async {
  // Register core dependencies
  await CoreDiModule.init(sl);
  
  // Register Firebase dependencies
  await FirebaseDiModule.init(sl);
  
  // Register feature modules dependencies
  await AuthDiModule.init(sl);
  await BookDiModule.init(sl);
  await ProfileDiModule.init(sl);
  await SearchDiModule.init(sl);
}