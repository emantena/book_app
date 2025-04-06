// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/config/environment_provider.dart';
import 'core/config/firebase_options.dart';
import 'core/di/di_setup.dart';
import 'core/ui/app_module.dart';

Future<void> main() async {
  // Garante que os widgets estão inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Define o ambiente como produção
  EnvironmentProvider.init(environment: AppEnvironment.prod);

  // Inicializa o Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicializa as dependências
  await initializeDependencies();

  // Inicia o aplicativo
  runApp(const AppModule());
}
