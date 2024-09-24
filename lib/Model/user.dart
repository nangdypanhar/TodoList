class User {
  String email;
  String password;
  String name;

  User({required this.email, required this.password, required this.name});

  User.fromJSON(Map<String, Object?> json)
      : this(
            email: json['email'] as String,
            password: json['password'] as String,
            name: json['name'] as String);

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
    };
  }
}
