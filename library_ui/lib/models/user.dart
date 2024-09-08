class User {

  final String token;

  final int id;
  final String name;
  final String email;
  final String password;

  User({required this.token,required this.id,required this.name,required this.email,required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      id: json['id'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
  };

}