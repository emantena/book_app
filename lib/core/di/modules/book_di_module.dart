// lib/core/dependency_injection/modules/book_di_module.dart
import 'package:get_it/get_it.dart';

import '../../../data/repositories/book_detail_repository_impl.dart';
import '../../../data/repositories/read_meta_repository.dart';
import '../../../data/sources/local/read_meta_service.dart';
import '../../../data/sources/remote/book_detail_datasource.dart';
import '../../../domain/interfaces/repositories/i_book_detail_repository.dart';
import '../../../domain/interfaces/repositories/i_read_meta_repository.dart';
import '../../../domain/interfaces/services/i_read_meta_service.dart';
import '../../../domain/usecases/add_book_shelf_usecase.dart';
import '../../../domain/usecases/change_read_status_usecase.dart';
import '../../../domain/usecases/delete_read_history_usecase.dart';
import '../../../domain/usecases/get_book_details_usecase.dart';
import '../../../domain/usecases/get_books_by_year_target_usecase.dart';
import '../../../domain/usecases/load_book_usecase.dart';
import '../../../domain/usecases/remove_read_meta_usecase.dart';
import '../../../domain/usecases/set_read_history_usecase.dart';
import '../../../domain/usecases/set_read_meta_usecase.dart';
import '../../../domain/usecases/show_bookshelf_usecase.dart';
import '../../../features/books/presentation/blocs/book_detail/book_detail_bloc.dart';
import '../../../features/books/presentation/blocs/book_options/book_options_bloc.dart';
import '../../../features/books/presentation/blocs/yearly_goals/yearly_goals_bloc.dart';
import '../../../features/bookshelves/presentation/bloc/bookshelf_bloc.dart';

class BookDiModule {
  static Future<void> init(GetIt sl) async {
    sl.registerLazySingleton<IBookDetailDatasource>(
      () => BookDetailDatasource(),
    );

    sl.registerLazySingleton<IReadMetaRepository>(
      () => ReadMetaRepository(sl()),
    );

    sl.registerLazySingleton<IReadMetaService>(
      () => ReadMetaService(sl(), sl(), sl()),
    );

    sl.registerLazySingleton<IBookDetailRepository>(
      () => BookDetailsRepository(sl()),
    );

    // UseCases - Book Details
    sl.registerLazySingleton(() => GetBookDetailsUsecase(sl(), sl()));
    sl.registerLazySingleton(() => AddBookShelfUseCase(sl(), sl()));

    // UseCases - Bookshelves
    sl.registerLazySingleton(() => ShowBookShelfUseCase(sl()));

    // UseCases - Book Options
    sl.registerLazySingleton(() => LoadBookUsecase(sl()));
    sl.registerLazySingleton(() => ChangeReadStatusUsecase(sl()));
    sl.registerLazySingleton(() => SetReadHistoryUsecase(sl()));
    sl.registerLazySingleton(() => DeleteReadHistoryUsecase(sl()));
    sl.registerLazySingleton(() => SetReadMetaUsecase(sl(), sl()));
    sl.registerLazySingleton(() => RemoveReadMetaUsecase(sl(), sl()));
    sl.registerLazySingleton(() => GetBooksByYearTargetUsecase(sl()));

    // Blocs
    sl.registerFactory(() => BookDetailBloc(sl(), sl()));
    sl.registerFactory(() => BookshelfBloc(sl(), sl()));
    sl.registerFactory(
        () => BookOptionsBloc(sl(), sl(), sl(), sl(), sl(), sl()));
    sl.registerFactory(() => YearlyGoalsBloc(sl()));
  }
}
