import 'package:book_app/core/firebase/repository/interfaces/i_user_repository.dart';
import 'package:book_app/core/firebase/service/interfaces/i_base_service.dart';

class BaseService implements IBaseService {
  late String _userId = '';
  final IUserRepository _userRepository;

  BaseService(this._userRepository);

  @override
  Future<String> getUserId() async {
    if (_userId.isNotEmpty) {
      return _userId;
    }

    final user = await _userRepository.getUser();
    _userId = user.id;

    return _userId;
  }
}
