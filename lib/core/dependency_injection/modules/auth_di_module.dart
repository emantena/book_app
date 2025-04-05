import 'package:get_it/get_it.dart';
import 'package:book_app/features/modules/auth/sign_up/domain/usecase/sign_up_usecase.dart';
import 'package:book_app/features/modules/auth/sign_in/domain/usecase/sign_in_usecase.dart';
import 'package:book_app/features/modules/auth/forgot_password/domain/usecase/forgot_password_usecase.dart';
import 'package:book_app/features/modules/auth/sign_up/presentation/controller/sign_up_cubit/sign_up_cubit.dart';
import 'package:book_app/features/modules/auth/sign_in/presentation/controllers/cubit/sign_in_cubit.dart';
import 'package:book_app/features/modules/auth/forgot_password/presentation/controller/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:book_app/features/modules/auth/splash/controller/cubit/splash_cubit.dart';
import 'package:book_app/features/modules/auth/forgot_password/data/datasource/forgot_password_datasource.dart';

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
