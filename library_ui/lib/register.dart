import 'package:flutter/material.dart';
import 'package:library_ui/functions.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
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
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
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
                onPressed: () {
                  register(_emailController.text, _usernameController.text, _passwordController.text);
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );}}