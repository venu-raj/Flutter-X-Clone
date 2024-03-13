import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:x_clone_flutter/core/failure/failure.dart';
import 'package:x_clone_flutter/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:x_clone_flutter/features/auth/domain/entity/user.dart';
import 'package:x_clone_flutter/features/auth/domain/repository/auth_repository.dart';

final userGoogleLoginProvider = Provider((ref) {
  return UserGoogleLogin(ref.watch(authRepositoryImplProvider));
});

class UserGoogleLogin {
  final AuthRepository authRepository;

  UserGoogleLogin(this.authRepository);

  Future<Either<Failure, User>> userGoogleLogin() async {
    return await authRepository.signupWithGoogle();
  }
}
