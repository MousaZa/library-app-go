import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:library_ui/controllers/auth_provider.dart';
import 'package:library_ui/views/home.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/user.dart';
import 'package:library_ui/views/profile.dart';

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
                  dynamic paseto = await login(_usernameController.text, _passwordController.text);
                   if(paseto != null) {
                  storage.write(key: "paseto", value: paseto);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage.withAuth(paseto),
                    )
                  );
                } else {
                  Get.defaultDialog(title:  "An Error Occurred",content: Text( "No account was found matching that username and password"));
                }
              },
                child: Text('Login'),
              ), 
            ],
          ),
        ),
      ),
    );}}