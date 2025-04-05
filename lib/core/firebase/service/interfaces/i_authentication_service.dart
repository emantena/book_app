import '../../models/user_model.dart';

abstract class IAuthenticationService {
  Future<bool> login(String email, String password);
  Future<UserModel?> register(String email, String password);
  Future<bool> resetPassword(String email);
  Future<bool> logOut();
  Future<UserModel> currentUser();
}
