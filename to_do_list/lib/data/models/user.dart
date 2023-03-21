class User {
  late String username;
  late String email;
  late String password;

  User({required this.username, required this.email, required this.password});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() =>
      {'username': username, 'email': email, 'password': password};
}
