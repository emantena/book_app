import '../../domain/interfaces/repositories/i_authentication_repository.dart';
import '../../domain/interfaces/repositories/i_authentication_service.dart';
import '../models/user_model.dart';

class AuthenticationService extends IAuthenticationService {
  final IAuthenticationRepository _authenticationRepository;

  AuthenticationService(this._authenticationRepository);

  @override
  Future<bool> logOut() {
    throw UnimplementedError();
  }

  @override
  Future<bool> login(String email, String password) async {
    await _authenticationRepository.login(email, password);
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> register(String email, String password) async {
    return await _authenticationRepository.register(email, password);
  }

  @override
  Future<bool> resetPassword(String email) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> currentUser() async {
    final user = await _authenticationRepository.user;

    return user;
  }
}
