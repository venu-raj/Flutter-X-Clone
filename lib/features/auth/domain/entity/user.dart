class User {
  final String name;
  final String? profilePic;
  final String uid;
  final String? phoneNumber;
  User({
    required this.name,
    this.profilePic,
    required this.uid,
    this.phoneNumber,
  });
}
