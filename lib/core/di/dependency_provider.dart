// lib/core/common/dependency_provider.dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DependencyProvider extends InheritedWidget {
  final GetIt sl;

  const DependencyProvider({
    super.key,
    required this.sl,
    required super.child,
  });

  static DependencyProvider of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<DependencyProvider>();
    if (provider == null) {
      throw Exception('Nenhum DependencyProvider encontrado no contexto');
    }
    return provider;
  }

  T get<T extends Object>() => sl.get<T>();

  @override
  bool updateShouldNotify(DependencyProvider oldWidget) => false;
}

extension DependencyProviderExtension on BuildContext {
  GetIt get sl => DependencyProvider.of(this).sl;

  T getDependency<T extends Object>() => sl.get<T>();
}
