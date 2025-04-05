// lib/core/app/app_module.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:book_app/core/common/dependency_provider.dart';
import 'package:book_app/core/dependency_injection/di_setup.dart';
import 'package:book_app/core/resources/app_strings.dart';
import 'package:book_app/core/resources/app_theme.dart';
import 'package:book_app/core/routes/app_router.dart';

/// Widget principal da aplicação que configura o MaterialApp
class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    _configureSystemUI();

    // Acessa o router através da injeção de dependência
    final appRouter = sl<AppRouter>();

    return DependencyProvider(
      sl: sl,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appTitle,
        theme: getApplicationTheme(),
        routerConfig: appRouter.router,
      ),
    );
  }

  /// Configura UI do sistema como orientação e cores da barra de status
  void _configureSystemUI() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );
  }
}
