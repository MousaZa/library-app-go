import 'package:flutter/material.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/profile.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Welcome to Library UI'),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              MaterialButton(
                onPressed: () async{
                  dynamic user = await login(_usernameController.text, _passwordController.text);
                  String username = user["user"]['username'];
                  String email = user["user"]['email'];
                  String id = user["user"]['id'];
                  String access_token = user['access_token'];
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(username: username, email: email, id: id, access_token: access_token)));
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );}}