import 'dart:convert';

class User {
  final String profilepic;
  final String about;
  final String name;
  final String email;
  final String username;
  User({
    required this.profilepic,
    required this.about,
    required this.name,
    required this.email,
    required this.username,
  });

  User copyWith({
    String? profilepic,
    String? about,
    String? name,
    String? email,
    String? username,
  }) {
    return User(
      profilepic: profilepic ?? this.profilepic,
      about: about ?? this.about,
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profilepic': profilepic,
      'about': about,
      'name': name,
      'email': email,
      'username': username,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      profilepic: map['profilepic'] ?? '',
      about: map['about'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(profilepic: $profilepic, about: $about, name: $name, email: $email, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.profilepic == profilepic &&
        other.about == about &&
        other.name == name &&
        other.email == email &&
        other.username == username;
  }

  @override
  int get hashCode {
    return profilepic.hashCode ^
        about.hashCode ^
        name.hashCode ^
        email.hashCode ^
        username.hashCode;
  }
}
