import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_clone_flutter/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:x_clone_flutter/features/auth/domain/entity/user.dart';
import 'package:x_clone_flutter/features/auth/domain/repository/auth_repository.dart';

final getCurrentUserDataProvider = Provider((ref) {
  return GetCurrentUserData(
    authRepository: ref.watch(authRepositoryImplProvider),
  );
});

class GetCurrentUserData {
  final AuthRepository authRepository;

  GetCurrentUserData({required this.authRepository});

  Future<User?> getCurrentUserData() async {
    final user = await authRepository.getCurrentUserData();
    if (user != null) {
      return user;
    }
    return null;
  }
}
