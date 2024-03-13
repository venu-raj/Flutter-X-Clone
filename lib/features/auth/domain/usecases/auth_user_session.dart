import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_clone_flutter/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:x_clone_flutter/features/auth/domain/repository/auth_repository.dart';

final authUserSessionProvider = Provider((ref) {
  return AuthUserSession(
    authRepository: ref.watch(authRepositoryImplProvider),
  );
});

class AuthUserSession {
  final AuthRepository authRepository;

  AuthUserSession({required this.authRepository});

  Stream<User?> get authStateChange {
    return authRepository.authStateChange;
  }
}
