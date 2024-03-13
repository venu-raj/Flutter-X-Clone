import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:x_clone_flutter/core/failure/failure.dart';
import 'package:x_clone_flutter/core/failure/server_exception.dart';
import 'package:x_clone_flutter/features/auth/data/models/user_model.dart';

final authdataSourceProvider = Provider<AuthDataSourceImpl>((ref) {
  return AuthDataSourceImpl(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

abstract interface class AuthDataSource {
  Future<Either<Failure, UserModel>> signiInWithGoogle();
  Stream<User?> get authStateChange;
  Future<UserModel?> getCurrentUserData();
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  AuthDataSourceImpl({
    required this.firestore,
    required this.auth,
  });

  @override
  Future<Either<Failure, UserModel>> signiInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final result = await auth.signInWithCredential(credential);

      UserModel userModel;

      if (result.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          name: result.user!.displayName ?? "",
          profilePic: result.user!.photoURL ?? "",
          uid: result.user!.uid,
          phoneNumber: result.user!.phoneNumber ?? "",
        );
        await firestore
            .collection("users")
            .doc(result.user!.uid)
            .set(userModel.toMap());
      } else {
        userModel = await getCurrentUserDataa();
      }

      return right(userModel);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<UserModel> getCurrentUserDataa() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    } else {
      throw ServerException("User Not found");
    }
    return user;
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    } else {
      throw ServerException("User Not found");
    }
    return user;
  }

  @override
  Stream<User?> get authStateChange => auth.authStateChanges();
}
