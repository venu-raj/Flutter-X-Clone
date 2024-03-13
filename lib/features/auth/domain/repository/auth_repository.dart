import 'package:fpdart/fpdart.dart';
import 'package:x_clone_flutter/core/failure/failure.dart';
import 'package:x_clone_flutter/features/auth/domain/entity/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as user;

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signupWithGoogle();
  Future<User?> getCurrentUserData();
  Stream<user.User?> get authStateChange;
}
