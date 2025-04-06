import '../../../data/models/user_model.dart';

abstract class IAuthenticationRepository {
  Future<UserModel?> login(String email, String password);
  Future<UserModel?> register(String email, String password);
  Future<bool> resetPassword(String email);
  Future<void> remove();
  Future<void> logOut();

  Future<UserModel> get user;
}
