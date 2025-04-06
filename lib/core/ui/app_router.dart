// lib/core/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../config/app_routes.dart';
import '../../presentation/blocs/book_detail/book_detail_bloc.dart';
import '../../presentation/blocs/book_options/book_options_bloc.dart';
import '../../presentation/blocs/bookshelf/bookshelf_bloc.dart';
import '../../presentation/blocs/category/category_cubit.dart';
import '../../presentation/blocs/forgot_password/forgot_password_cubit.dart';
import '../../presentation/blocs/profile/profile_cubit.dart';
import '../../presentation/blocs/search/search_bloc.dart';
import '../../presentation/blocs/sign_in/sign_in_cubit.dart';
import '../../presentation/blocs/sign_up/sign_up_cubit.dart';
import '../../presentation/blocs/splash/splash_cubit.dart';
import '../../presentation/pages/auth/forgot_password_view.dart';
import '../../presentation/pages/auth/sign_up_view.dart';
import '../../presentation/pages/auth/sign_view.dart';
import '../../presentation/pages/auth/splash_view.dart';
import '../../presentation/pages/books/book_details_view.dart';
import '../../presentation/pages/books/book_options_view.dart';
import '../../presentation/pages/books/bookshelves_view.dart';
import '../../presentation/pages/home/home_view.dart';
import '../../presentation/pages/main_page.dart';
import '../../presentation/pages/profile/profile_view.dart';
import '../../presentation/pages/profile/selfie_view.dart';
import '../../presentation/pages/search/search_view.dart';

// Constantes de rotas
const String splashPath = '/splash';
const String signInPath = '/signIn';
const String signUpPath = '/signUp';
const String forgotPasswordPath = '/forgotPassword';
const String homePath = '/home';
const String searchPath = '/search';
const String bookDetailPath = '/bookDetail/:bookId';
const String bookOptionsPath = '/bookOptions/:bookId';
const String bookshelvePath = '/bookshelve';
const String profilePath = '/profile';
const String photoPath = '/photo';

class AppRouter {
  final GetIt _sl;

  AppRouter(this._sl);

  GoRouter get router => GoRouter(
        initialLocation: splashPath,
        routes: [
          GoRoute(
            name: AppRoutes.splashRoute,
            path: splashPath,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (_) => _sl<SplashCubit>(),
                child: const SplashView(),
              ),
            ),
          ),
          GoRoute(
            name: AppRoutes.signInRoute,
            path: signInPath,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (_) => _sl<SignInCubit>(),
                child: const SignInView(),
              ),
            ),
          ),
          GoRoute(
            name: AppRoutes.signUpRoute,
            path: signUpPath,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (_) => _sl<SignUpCubit>(),
                child: const SignUpView(),
              ),
            ),
          ),
          GoRoute(
            name: AppRoutes.forgotPasswordRoute,
            path: forgotPasswordPath,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider<ForgotPasswordCubit>(
                create: (_) => _sl<ForgotPasswordCubit>(),
                child: const ForgotPasswordView(),
              ),
            ),
          ),
          GoRoute(
            name: AppRoutes.bookDetailRoute,
            path: bookDetailPath,
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
            path: bookOptionsPath,
            pageBuilder: (context, state) => MaterialPage(
              child: BlocProvider(
                create: (_) => _sl<BookOptionsBloc>(),
                child: BookOptionsView(
                  bookId: state.pathParameters['bookId']!,
                ),
              ),
            ),
          ),
          ShellRoute(
            builder: (context, state, child) => MainPage(child: child),
            routes: [
              GoRoute(
                name: AppRoutes.homeRoute,
                path: homePath,
                pageBuilder: (context, state) => const MaterialPage(
                  child: HomeView(),
                ),
                routes: const [],
              ),
              GoRoute(
                name: AppRoutes.searchRoute,
                path: searchPath,
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
                path: bookshelvePath,
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
                path: profilePath,
                pageBuilder: (context, state) => MaterialPage(
                  child: BlocProvider(
                    create: (_) => _sl<ProfileCubit>(),
                    child: const ProfileView(),
                  ),
                ),
                routes: [
                  GoRoute(
                    name: AppRoutes.selfieRoute,
                    path: photoPath,
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
