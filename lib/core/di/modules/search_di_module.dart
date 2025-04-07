// lib/core/dependency_injection/modules/search_di_module.dart
import 'package:get_it/get_it.dart';

import '../../../data/repositories/search_repository_impl.dart';
import '../../../data/sources/remote/category_data_source.dart';
import '../../../data/sources/remote/search_remote_data_source.dart';
import '../../../domain/interfaces/repositories/i_search_repository.dart';
import '../../../domain/usecases/category_list_usecase.dart';
import '../../../domain/usecases/search_usecase.dart';
import '../../../features/search/presentation/bloc/category/category_cubit.dart';
import '../../../features/search/presentation/bloc/search/search_bloc.dart';

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
