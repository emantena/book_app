import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import '../../../data/repositories/authentication_repository.dart';
import '../../../data/repositories/book_shelf_repository.dart';
import '../../../data/repositories/category_repository.dart';
import '../../../data/repositories/read_history_repository.dart';
import '../../../data/repositories/shelf_item_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/sources/authentication_service.dart';
import '../../../data/sources/base_service.dart';
import '../../../data/sources/book_shelf_service.dart';
import '../../../data/sources/read_history_service.dart';
import '../../../data/sources/shelf_item_service.dart';
import '../../../domain/interfaces/repositories/i_authentication_repository.dart';
import '../../../domain/interfaces/repositories/i_authentication_service.dart';
import '../../../domain/interfaces/repositories/i_base_service.dart';
import '../../../domain/interfaces/repositories/i_book_shelf_service.dart';
import '../../../domain/interfaces/repositories/i_read_history_repository.dart';
import '../../../domain/interfaces/repositories/i_read_history_service.dart';
import '../../../domain/interfaces/repositories/i_shelf_item_repository.dart';
import '../../../domain/interfaces/repositories/i_shelf_item_service.dart';
import '../../../domain/interfaces/repositories/i_user_repository.dart';

class FirebaseDiModule {
  static Future<void> init(GetIt sl) async {
    sl.registerLazySingleton(() => FirebaseAuth.instance);
    sl.registerLazySingleton(() => FirebaseFirestore.instance);
    sl.registerLazySingleton(() => FirebaseStorage.instance);

    sl.registerLazySingleton<IAuthenticationRepository>(
      () => AuthenticationRepository(sl()),
    );

    sl.registerLazySingleton<IAuthenticationService>(
      () => AuthenticationService(sl()),
    );

    sl.registerLazySingleton<IUserRepository>(
      () => UserRepository(sl(), sl()),
    );

    sl.registerLazySingleton<ICategoryRepository>(
      () => CategoryRepository(sl()),
    );

    sl.registerLazySingleton<IBookShelfRepository>(
      () => BookShelfRepository(sl()),
    );

    sl.registerLazySingleton<IReadHistoryRepository>(
      () => ReadHistoryRepository(sl()),
    );

    sl.registerLazySingleton<IShelfItemRepository>(
      () => ShelfItemRepository(sl()),
    );

    sl.registerLazySingleton<IBaseService>(
      () => BaseService(sl()),
    );

    sl.registerLazySingleton<IReadHistoryService>(
      () => ReadHistoryService(sl(), sl(), sl()),
    );

    sl.registerLazySingleton<IShelfItemService>(
      () => ShelfItemService(sl(), sl(), sl()),
    );

    sl.registerLazySingleton<IBookShelfService>(
      () => BookShelfService(sl(), sl()),
    );
  }
}
