import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/controllers/auth.dart';
import 'package:library_ui/views/home.dart';
import 'package:library_ui/globals.dart';

import 'package:library_ui/views/register.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final controller = Get.put(Auth());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: SizedBox(
          width: 40.w,
          height: 50.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Welcome to Library UI',style: TextStyle(fontSize: 18.sp),),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder()
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder()
                ),
              ),
              Container(
                width: 20.w,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MaterialButton(
                  onPressed: () async{
                    dynamic paseto = await controller.login(_usernameController.text, _passwordController.text);
                     if(paseto != null && paseto != 'error')  {
                    storage.write(key: "paseto", value: paseto);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage.withAuth(paseto),
                      )
                    );
                  }
                },
                  child: Text('Login',style: TextStyle(color: Theme.of(context).colorScheme.onPrimary,fontSize: 11.sp),),
                ),
              ), 
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                child: Text('Register'), 
              ),
            ],
          ),
        ),
      ),
    );}}