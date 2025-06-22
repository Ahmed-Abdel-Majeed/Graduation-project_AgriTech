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

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'id': id,
      'email': email,
      'username': username,
      'image': image,
    };
  }

  factory AppUserEntity.fromJson(Map<String, dynamic> json) {
    return AppUserEntity(
      token: json['token'],
      id: json['id'],
      email: json['email'],
      username: json['username'],
      image: json['image'],
    );
  }
}
