// lib/core/dependency_injection/modules/profile_di_module.dart
import 'package:get_it/get_it.dart';
import 'package:book_app/features/modules/profile/domain/usecase/profile_usecase.dart';
import 'package:book_app/features/modules/profile/domain/usecase/sign_out_usecase.dart';
import 'package:book_app/features/modules/profile/domain/usecase/photo_usecase.dart';
import 'package:book_app/features/modules/profile/presentation/controller/cubit/profile_cubit.dart';

/// Module for profile related dependencies
class ProfileDiModule {
  /// Initialize profile dependencies
  static Future<void> init(GetIt sl) async {
    // UseCases
    sl.registerLazySingleton(() => ProfileUsecase(sl()));
    sl.registerLazySingleton(() => SignOutUsecase(sl()));
    sl.registerLazySingleton(() => PhotoUsecase(sl()));

    // Controllers (Cubits)
    sl.registerFactory(() => ProfileCubit(sl(), sl(), sl()));
  }
}
