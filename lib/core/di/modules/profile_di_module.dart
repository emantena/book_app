import 'package:get_it/get_it.dart';

import '../../../domain/usecases/photo_usecase.dart';
import '../../../domain/usecases/profile_usecase.dart';
import '../../../domain/usecases/sign_out_usecase.dart';
import '../../../features/profile/presentation/bloc/profile_cubit.dart';

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
