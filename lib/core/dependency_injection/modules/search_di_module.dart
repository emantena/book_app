// lib/core/dependency_injection/modules/search_di_module.dart
import 'package:get_it/get_it.dart';
import 'package:book_app/features/modules/search/data/datasource/search_remote_data_source.dart';
import 'package:book_app/features/modules/search/data/datasource/category_data_source.dart';
import 'package:book_app/features/modules/search/data/repository/search_repository_impl.dart';
import 'package:book_app/features/modules/search/domain/repository/search_repository.dart';
import 'package:book_app/features/modules/search/domain/usecases/search_usecase.dart';
import 'package:book_app/features/modules/search/domain/usecases/category_list_usecase.dart';
import 'package:book_app/features/modules/search/presentation/controllers/bloc/search_bloc/search_bloc.dart';
import 'package:book_app/features/modules/search/presentation/controllers/cubit/category_list_cubit/category_cubit.dart';

/// Module for search related dependencies
class SearchDiModule {
  /// Initialize search dependencies
  static Future<void> init(GetIt sl) async {
    // DataSources
    sl.registerLazySingleton<ISearchRemoteDataSource>(
      () => SearchRemoteDataSource(),
    );

    sl.registerLazySingleton<ICategoryDataSource>(
      () => CategoryDataSource(),
    );

    // Repositories
    sl.registerLazySingleton<ISearchRepository>(
      () => SearchRepository(sl()),
    );

    // UseCases
    sl.registerLazySingleton(() => SearchUseCase(sl()));
    sl.registerLazySingleton(() => CategoryListUseCase(sl(), sl()));

    // Controllers
    sl.registerFactory(() => SearchBloc(sl()));
    sl.registerFactory(() => CategoryCubit(sl()));
  }
}
