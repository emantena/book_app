import 'package:book_app/core/firebase/models/user_model.dart';
import 'package:book_app/core/firebase/service/interfaces/i_authentication_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final IAuthenticationService _firebaseAuth;

  SplashCubit(this._firebaseAuth) : super(SplashInitial()) {
    checkAuth();
  }

  Future<void> checkAuth() async {
    try {
      final user = await _firebaseAuth.currentUser();
      if (user == UserModel.empty) {
        emit(Unauthenticated());
      } else {
        emit(Authenticated(user));
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }
}
