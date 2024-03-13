import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:x_clone_flutter/core/failure/failure.dart';
import 'package:x_clone_flutter/features/auth/data/datasource/auth_data_source.dart';
import 'package:x_clone_flutter/features/auth/domain/entity/user.dart';
import 'package:x_clone_flutter/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as user;

final authRepositoryImplProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(ref.watch(authdataSourceProvider));
});

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Either<Failure, User>> signupWithGoogle() async {
    try {
      return await authDataSource.signiInWithGoogle();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<User?> getCurrentUserData() async {
    final user = await authDataSource.getCurrentUserData();
    if (user != null) {
      return user;
    }
    return null;
  }

  @override
  Stream<user.User?> get authStateChange => authDataSource.authStateChange;
}
