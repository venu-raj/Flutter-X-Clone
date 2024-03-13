import 'package:x_clone_flutter/features/auth/domain/entity/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    required super.profilePic,
    required super.uid,
    required super.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'profilePic': profilePic});
    result.addAll({'uid': uid});
    result.addAll({'phoneNumber': phoneNumber});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }

  User copyWith({
    String? name,
    String? profilePic,
    String? uid,
    String? phoneNumber,
  }) {
    return User(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
