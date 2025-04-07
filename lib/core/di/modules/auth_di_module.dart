import 'package:get_it/get_it.dart';

import '../../../data/sources/remote/forgot_password_datasource.dart';
import '../../../domain/usecases/forgot_password_usecase.dart';
import '../../../domain/usecases/sign_in_usecase.dart';
import '../../../domain/usecases/sign_up_usecase.dart';
import '../../../features/auth/presentation/blocs/forgot_password/forgot_password_cubit.dart';
import '../../../features/auth/presentation/blocs/sign_in/sign_in_cubit.dart';
import '../../../features/auth/presentation/blocs/sign_up/sign_up_cubit.dart';
import '../../../features/auth/presentation/blocs/splash/splash_cubit.dart';

class AuthDiModule {
  static Future<void> init(GetIt sl) async {
    // UseCases
    sl.registerLazySingleton(() => SignUpUsecase(sl(), sl()));
    sl.registerLazySingleton(() => SignInUsecase(sl(), sl()));
    sl.registerLazySingleton(() => ForgotPasswordUsecase(sl()));

    // DataSources
    sl.registerLazySingleton<IForgotPasswordDatasource>(
      () => ForgotPasswordDatasourceImpl(),
    );

    // Controllers (Cubits)
    sl.registerFactory(() => SignUpCubit(sl()));
    sl.registerFactory(() => SignInCubit(sl(), sl()));
    sl.registerFactory(() => ForgotPasswordCubit(sl()));
    sl.registerFactory(() => SplashCubit(sl()));
  }
}
