// lib/core/dependency_injection/modules/search_di_module.dart
import 'package:get_it/get_it.dart';

import '../../../data/repositories/search_repository_impl.dart';
import '../../../data/sources/category_data_source.dart';
import '../../../data/sources/search_remote_data_source.dart';
import '../../../domain/interfaces/repositories/i_search_repository.dart';
import '../../../domain/usecases/category_list_usecase.dart';
import '../../../domain/usecases/search_usecase.dart';
import '../../../presentation/blocs/category/category_cubit.dart';
import '../../../presentation/blocs/search/search_bloc.dart';

class SearchDiModule {
  static Future<void> init(GetIt sl) async {
    sl.registerLazySingleton<ISearchRemoteDataSource>(
      () => SearchRemoteDataSource(),
    );

    sl.registerLazySingleton<ICategoryDataSource>(
      () => CategoryDataSource(),
    );

    sl.registerLazySingleton<ISearchRepository>(
      () => SearchRepository(sl()),
    );

    sl.registerLazySingleton(() => SearchUseCase(sl()));
    sl.registerLazySingleton(() => CategoryListUseCase(sl(), sl()));

    sl.registerFactory(() => SearchBloc(sl()));
    sl.registerFactory(() => CategoryCubit(sl()));
  }
}
