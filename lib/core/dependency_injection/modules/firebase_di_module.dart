// lib/core/dependency_injection/modules/firebase_di_module.dart
import 'package:book_app/core/firebase/repository/interfaces/i_user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:book_app/core/firebase/service/interfaces/i_authentication_service.dart';
import 'package:book_app/core/firebase/service/authentication_service.dart';
import 'package:book_app/core/firebase/repository/interfaces/i_authentication_repository.dart';
import 'package:book_app/core/firebase/repository/authentication_repository.dart';
import 'package:book_app/core/firebase/repository/user_repository.dart';
import 'package:book_app/core/firebase/repository/category_repository.dart';
import 'package:book_app/core/firebase/repository/book_shelf_repository.dart';
import 'package:book_app/core/firebase/repository/interfaces/i_read_history_repository.dart';
import 'package:book_app/core/firebase/repository/read_history_repository.dart';
import 'package:book_app/core/firebase/repository/interfaces/i_shelf_item_repository.dart';
import 'package:book_app/core/firebase/repository/shelf_item_repository.dart';
import 'package:book_app/core/firebase/service/interfaces/i_base_service.dart';
import 'package:book_app/core/firebase/service/base_service.dart';
import 'package:book_app/core/firebase/service/interfaces/i_read_history_service.dart';
import 'package:book_app/core/firebase/service/read_history_service.dart';
import 'package:book_app/core/firebase/service/interfaces/i_shelf_item_service.dart';
import 'package:book_app/core/firebase/service/shelf_item_service.dart';
import 'package:book_app/core/firebase/service/interfaces/i_book_shelf_service.dart';
import 'package:book_app/core/firebase/service/book_shelf_service.dart';

/// Module for Firebase related dependencies
class FirebaseDiModule {
  /// Initialize Firebase dependencies
  static Future<void> init(GetIt sl) async {
    // Firebase instances
    sl.registerLazySingleton(() => FirebaseAuth.instance);
    sl.registerLazySingleton(() => FirebaseFirestore.instance);
    sl.registerLazySingleton(() => FirebaseStorage.instance);

    // Auth repositories
    sl.registerLazySingleton<IAuthenticationRepository>(
      () => AuthenticationRepository(sl()),
    );
    
    // Auth services
    sl.registerLazySingleton<IAuthenticationService>(
      () => AuthenticationService(sl()),
    );
    
    // User repository
    sl.registerLazySingleton<IUserRepository>(
      () => UserRepository(sl(), sl()),
    );
    
    // Category repository
    sl.registerLazySingleton<ICategoryRepository>(
      () => CategoryRepository(sl()),
    );
    
    // Bookshelf repositories
    sl.registerLazySingleton<IBookShelfRepository>(
      () => BookShelfRepository(sl()),
    );
    
    sl.registerLazySingleton<IReadHistoryRepository>(
      () => ReadHistoryRepository(sl()),
    );
    
    sl.registerLazySingleton<IShelfItemRepository>(
      () => ShelfItemRepository(sl()),
    );
    
    // Base services
    sl.registerLazySingleton<IBaseService>(
      () => BaseService(sl()),
    );
    
    // Bookshelf services
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