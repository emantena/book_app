import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/user_model.dart';
import '../../core/error/failure.dart';
import '../../domain/interfaces/repositories/i_authentication_repository.dart';
import '../../domain/interfaces/repositories/i_user_repository.dart';

class UserRepository implements IUserRepository {
  static const String userKey = '__user_key__';
  static const userCollection = 'users';

  final FirebaseFirestore _firestore;
  final IAuthenticationRepository _authRepository;

  UserRepository(
    this._firestore,
    this._authRepository,
  );

  @override
  Future<UserModel> getUser() async {
    final authUser = await _authRepository.user;

    final user = await _firestore.collection(userCollection).doc(authUser.id).get().then(
      (userResult) {
        final usermodel = UserModel.fromJson(userResult.data()!, authUser.id);
        return usermodel;
      },
    );

    return user;
  }

  @override
  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore.collection(userCollection).doc(user.id).update(user.toJson());
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<void> createUser(String userId, String email, String name, DateTime dateOfBirth) async {
    try {
      await _firestore.collection(userCollection).doc(userId).set({
        'id': userId,
        'email': email,
        'name': name,
        'birthDate': dateOfBirth.toIso8601String(),
      });
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<void> addPhoto(XFile image) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final storageRef = FirebaseStorage.instance.ref().child(
          'images/$fileName.${image.name.split('.').last}',
        );
    try {
      storageRef.putFile(File(image.path)).snapshotEvents.listen(
        (snapshot) async {
          if (snapshot.state == TaskState.success) {
            final photoUrl = await snapshot.ref.getDownloadURL();
            final currentUser = await getUser();

            await _firestore.collection(userCollection).doc(currentUser.id).update(
              {
                'photo': photoUrl,
              },
            );
          } else if (snapshot.state == TaskState.error) {
            throw const DatabaseFailure("Ocorreu um erro inesperado");
          }
        },
      );

      return Future.value();
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }
}
