import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';

import '../../core/firebase/exceptions/log_out_failure.dart';
import '../../core/firebase/exceptions/sign_in_failure.dart';
import '../../core/firebase/exceptions/sign_up_with_email_and_password_failure.dart';
import '../../domain/interfaces/repositories/i_authentication_repository.dart';
import '../models/user_model.dart';

class AuthenticationRepository extends IAuthenticationRepository {
  static const userCollection = 'users';
  final firebase_auth.FirebaseAuth _firebaseAuth;
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  AuthenticationRepository(this._firebaseAuth);

  @override
  Future<UserModel?> login(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user?.toUser;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignInFailure.fromCode(e.code);
    } catch (_) {
      throw const SignInFailure();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await Future.wait(<Future<void>>[
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }

  @override
  Future<UserModel?> register(String email, String password) async {
    try {
      var user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return user.user?.toUser;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<bool> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return Future.value(true);
  }

  @override
  Future<UserModel> get user async {
    return await _firebaseAuth.authStateChanges().map(
      (firebaseUser) {
        final user = firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
        return user;
      },
    ).first;
  }

  @override
  Future<void> remove() async {
    await _firebaseAuth.currentUser?.delete();
  }
}

extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
