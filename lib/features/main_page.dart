import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/ui/routes/app_path.dart';
import '../core/ui/routes/app_routes.dart';
import '../core/config/app_strings.dart';
import '../core/config/app_values.dart';

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({
    super.key,
    required this.child,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: widget.child,
        onPopInvokedWithResult: (didPop, result) async {
          final String location = GoRouterState.of(context).uri.toString();
          if (!location.startsWith(AppPath.homePath)) {
            _onItemTapped(0, context);
          }
          return;
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        items: const [
          BottomNavigationBarItem(
            label: AppStrings.home,
            icon: Icon(
              Icons.home_rounded,
              size: AppSize.s20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.search,
            icon: Icon(
              Icons.search_outlined,
              size: AppSize.s20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.bookshelves,
            icon: Icon(
              Icons.shelves,
              size: AppSize.s20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.profile,
            icon: Icon(
              Icons.person,
              size: AppSize.s20,
            ),
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppPath.homePath)) {
      return 0;
    }

    if (location.startsWith(AppPath.searchPath)) {
      return 1;
    }

    if (location.startsWith(AppPath.bookshelvePath)) {
      return 2;
    }

    if (location.startsWith(AppPath.profilePath)) {
      return 3;
    }

    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.homeRoute);
        break;
      case 1:
        context.goNamed(AppRoutes.searchRoute);
        break;
      case 2:
        context.goNamed(AppRoutes.bookshelveRoute);
        break;
      case 3:
        context.goNamed(AppRoutes.profileRoute);
        break;
    }
  }
}
