class AppUserEntity {
  final String? token;
  final String id;
  final String email;
  final String username;
  final String image;

  AppUserEntity({
    this.token,
    required this.id,
    required this.email,
    required this.username,
    required this.image,
  });
}
