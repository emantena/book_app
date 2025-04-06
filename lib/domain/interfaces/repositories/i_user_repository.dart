import 'package:camera/camera.dart';

import '../../../data/models/user_model.dart';

abstract class IUserRepository {
  Future<UserModel> getUser();
  Future<void> updateUser(UserModel user);
  Future<void> createUser(String userId, String email, String name, DateTime dateOfBirth);
  Future<void> addPhoto(XFile image);
}
