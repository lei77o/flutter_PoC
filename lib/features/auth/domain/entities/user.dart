class User{
  final String id;
  final String userName;
  final String email;
  final String fullName;
  final List<String> roles;
  final String token;
  final String userType;

  User({
    required this.email,
    required this.fullName,
    required this.userName,
    required this.id,
    required this.roles,
    required this.token,
    required this.userType
    });

  bool get isAdmin{
    return roles.contains('admin');
  }
}