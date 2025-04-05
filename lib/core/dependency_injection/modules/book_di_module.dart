// lib/core/dependency_injection/modules/book_di_module.dart
import 'package:get_it/get_it.dart';
import 'package:book_app/features/modules/book_detail/domain/usecase/get_book_details_usecase.dart';
import 'package:book_app/features/modules/book_detail/domain/usecase/add_book_shelf_usecase.dart';
import 'package:book_app/features/modules/book_detail/data/datasource/book_detail_datasource.dart';
import 'package:book_app/features/modules/book_detail/data/repository/book_detail_repository_impl.dart';
import 'package:book_app/features/modules/book_detail/domain/repository/book_detail_repository.dart';
import 'package:book_app/features/modules/book_detail/presentation/controller/book_detail_bloc/book_detail_bloc.dart';
import 'package:book_app/features/modules/bookshelves/domain/use_case/show_bookshelf_usecase.dart';
import 'package:book_app/features/modules/bookshelves/presentation/controllers/bloc/bookshelf_bloc.dart';
import 'package:book_app/features/modules/book_options/domain/usecase/load_book_usecase.dart';
import 'package:book_app/features/modules/book_options/domain/usecase/change_read_status_usecase.dart';
import 'package:book_app/features/modules/book_options/domain/usecase/set_read_history_usecase.dart';
import 'package:book_app/features/modules/book_options/domain/usecase/delete_read_history_usecase.dart';
import 'package:book_app/features/modules/book_options/presentation/controllers/bloc/book_options_bloc.dart';

/// Module for book related dependencies
class BookDiModule {
  /// Initialize book dependencies
  static Future<void> init(GetIt sl) async {
    // DataSources
    sl.registerLazySingleton<IBookDetailDatasource>(
      () => BookDetailDatasource(),
    );

    // Repositories
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

    // Blocs
    sl.registerFactory(() => BookDetailBloc(sl(), sl()));
    sl.registerFactory(() => BookshelfBloc(sl()));
    sl.registerFactory(() => BookOptionsBloc(sl(), sl(), sl(), sl()));
  }
}
