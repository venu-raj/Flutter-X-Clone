import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_clone_flutter/core/utils/show_snack_bar.dart';
import 'package:x_clone_flutter/features/auth/domain/entity/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:x_clone_flutter/features/auth/domain/usecases/auth_user_session.dart';
import 'package:x_clone_flutter/features/auth/domain/usecases/get_current_user_data.dart';
import 'package:x_clone_flutter/features/auth/domain/usecases/user_google_login.dart';

final authProvider = Provider<AuthProvider>((ref) {
  return AuthProvider(
    googleLogin: ref.watch(userGoogleLoginProvider),
    getCurrentUserData: ref.watch(getCurrentUserDataProvider),
    authUserSession: ref.watch(authUserSessionProvider),
  );
});

final authStateChangeProvider = StreamProvider((ref) {
  return ref.watch(authProvider).authStateChange;
});

final userGoogleLoginProviderr =
    FutureProvider.family((ref, BuildContext context) {
  return ref.watch(authProvider).userGoogleLogin(context: context);
});

final getCurrentUerDataProvider = FutureProvider((ref) {
  return ref.watch(authProvider).getCurrentUerData();
});

class AuthProvider {
  final UserGoogleLogin googleLogin;
  final GetCurrentUserData getCurrentUserData;
  final AuthUserSession authUserSession;

  AuthProvider({
    required this.googleLogin,
    required this.getCurrentUserData,
    required this.authUserSession,
  });

  Stream<auth.User?> get authStateChange {
    return authUserSession.authStateChange;
  }

  void userGoogleLogin({
    required BuildContext context,
  }) async {
    final res = await googleLogin.userGoogleLogin();

    res.fold(
      (l) => showsnackBar(context, l.error),
      (r) => showsnackBar(context, "Successfully created account"),
    );
  }

  Future<User?> getCurrentUerData() async {
    final res = await getCurrentUserData.getCurrentUserData();

    return res;
  }
}
