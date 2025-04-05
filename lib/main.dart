// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:book_app/core/app/app_module.dart';
import 'package:book_app/core/dependency_injection/di_setup.dart';
import 'package:book_app/core/firebase/options/firebase_options.dart';
import 'package:book_app/core/utils/environment_provider.dart';

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
