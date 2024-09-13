class User {

  final String token;

  final int id;
  final String name;
  final String email;
  final String password;

  User({required this.token,required this.id,required this.name,required this.email,required this.password});
  const User.empty() : token = '', id = 0, name = '', email = '', password = '';
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['user']['username'],
      email: json['user']['email'],
      password: json['user']['password'],
      id: json['user']['id'],
      token: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
  };

}