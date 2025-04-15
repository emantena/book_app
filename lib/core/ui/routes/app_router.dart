// lib/core/routes/app_router.dart
import 'package:book_app/core/di/dependency_provider.dart';
import 'package:book_app/core/ui/routes/app_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../features/books/presentation/blocs/yearly_goals/yearly_goals_bloc.dart';
import '../../../features/books/presentation/pages/yearly_goals/yearly_goals_view.dart';
import 'app_routes.dart';
import '../../../features/books/presentation/blocs/book_detail/book_detail_bloc.dart';
import '../../../features/books/presentation/blocs/book_options/book_options_bloc.dart';
import '../../../features/bookshelves/presentation/bloc/bookshelf_bloc.dart';
import '../../../features/search/presentation/bloc/category/category_cubit.dart';
import '../../../features/auth/presentation/blocs/forgot_password/forgot_password_cubit.dart';
import '../../../features/profile/presentation/bloc/profile_cubit.dart';
import '../../../features/search/presentation/bloc/search/search_bloc.dart';
import '../../../features/auth/presentation/blocs/sign_in/sign_in_cubit.dart';
import '../../../features/auth/presentation/blocs/sign_up/sign_up_cubit.dart';
import '../../../features/auth/presentation/blocs/splash/splash_cubit.dart';
import '../../../features/auth/presentation/pages/forgot_password/forgot_password_view.dart';
import '../../../features/auth/presentation/pages/sign_up/sign_up_view.dart';
import '../../../features/auth/presentation/pages/sign_in/sign_view.dart';
import '../../../features/auth/presentation/pages/splash_view.dart';
import '../../../features/books/presentation/pages/book_details/book_details_view.dart';
import '../../../features/books/presentation/pages/book_options/book_options_view.dart';
import '../../../features/bookshelves/presentation/pages/bookshelves_view.dart';
import '../../../features/home/presentation/pages/home_view.dart';
import '../../../features/main_page.dart';
import '../../../features/profile/presentation/pages/profile_view.dart';
import '../../../features/profile/presentation/pages/selfie_view.dart';
import '../../../features/search/presentation/pages/search_view.dart';

class AppRouter {
  final GetIt _sl;

  AppRouter(this._sl);

  GoRouter get router => GoRouter(
        initialLocation: AppPath.splashPath,
        routes: [
          GoRoute(
            name: AppRoutes.splashRoute,
            path: AppPath.splashPath,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (_) => _sl<SplashCubit>(),
                child: const SplashView(),
              ),
            ),
          ),
          GoRoute(
            name: AppRoutes.signInRoute,
            path: AppPath.signInPath,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (_) => _sl<SignInCubit>(),
                child: const SignInView(),
              ),
            ),
          ),
          GoRoute(
            name: AppRoutes.signUpRoute,
            path: AppPath.signUpPath,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (_) => _sl<SignUpCubit>(),
                child: const SignUpView(),
              ),
            ),
          ),
          GoRoute(
            name: AppRoutes.forgotPasswordRoute,
            path: AppPath.forgotPasswordPath,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider<ForgotPasswordCubit>(
                create: (_) => _sl<ForgotPasswordCubit>(),
                child: const ForgotPasswordView(),
              ),
            ),
          ),
          GoRoute(
            name: AppRoutes.bookDetailRoute,
            path: AppPath.bookDetailPath,
            pageBuilder: (context, state) => MaterialPage(
              child: BlocProvider(
                create: (_) => _sl<BookDetailBloc>(),
                child: BookDetailsView(
                  bookId: state.pathParameters['bookId']!,
                ),
              ),
            ),
          ),
          GoRoute(
            name: AppRoutes.bookOptionsRoute,
            path: AppPath.bookOptionsPath,
            pageBuilder: (context, state) => MaterialPage(
              child: BlocProvider(
                create: (_) => _sl<BookOptionsBloc>(),
                child: BookOptionsView(
                  bookId: state.pathParameters['bookId']!,
                ),
              ),
            ),
          ),
          GoRoute(
            name: AppRoutes.yearlyGoalsRoute,
            path: AppPath.yearlyGoalsPath,
            pageBuilder: (context, state) => MaterialPage(
              child: BlocProvider(
                create: (_) => _sl<YearlyGoalsBloc>(),
                child: const YearlyGoalsView(),
              ),
            ),
          ),
          ShellRoute(
            builder: (context, state, child) => MainPage(child: child),
            routes: [
              GoRoute(
                name: AppRoutes.homeRoute,
                path: AppPath.homePath,
                pageBuilder: (context, state) => MaterialPage(
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (_) => _sl<BookshelfBloc>(),
                      ),
                      BlocProvider(
                        create: (_) => _sl<YearlyGoalsBloc>(),
                      ),
                      BlocProvider(
                        create: (_) => context.sl<ProfileCubit>()..getUser(),
                      ),
                    ],
                    child: const HomeView(),
                  ),
                ),
                routes: const [],
              ),
              GoRoute(
                name: AppRoutes.searchRoute,
                path: AppPath.searchPath,
                pageBuilder: (context, state) => MaterialPage(
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (_) => _sl<SearchBloc>(),
                      ),
                      BlocProvider(
                        create: (_) => _sl<CategoryCubit>()..loadCategories(),
                      ),
                    ],
                    child: const SearchView(),
                  ),
                ),
                routes: const [],
              ),
              GoRoute(
                name: AppRoutes.bookshelveRoute,
                path: AppPath.bookshelvePath,
                pageBuilder: (context, state) => MaterialPage(
                  child: BlocProvider(
                    create: (_) => _sl<BookshelfBloc>(),
                    child: const BookShelveView(),
                  ),
                ),
                routes: const [],
              ),
              GoRoute(
                name: AppRoutes.profileRoute,
                path: AppPath.profilePath,
                pageBuilder: (context, state) => MaterialPage(
                  child: BlocProvider(
                    create: (_) => _sl<ProfileCubit>(),
                    child: const ProfileView(),
                  ),
                ),
                routes: [
                  GoRoute(
                    name: AppRoutes.selfieRoute,
                    path: AppPath.photoPath,
                    pageBuilder: (context, state) => MaterialPage(
                      child: BlocProvider(
                        create: (_) => _sl<ProfileCubit>(),
                        child: const SelfieView(),
                      ),
                    ),
                    routes: const [],
                  )
                ],
              ),
            ],
          ),
        ],
      );
}
