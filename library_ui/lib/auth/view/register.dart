import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/controllers/auth.dart';
import 'package:sizer/sizer.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  final controller = Get.put(Auth());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body: Center(
        child: SizedBox(
          width: 40.w,
          height: 50.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Welcome to Library UI', style: TextStyle(fontSize: 18.sp),),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder()
                ),
              ),
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
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MaterialButton(
                  onPressed: ()async {
                    final user = await controller.register(_emailController.text, _usernameController.text, _passwordController.text);
                    if (user != 'error') {
                         Get.snackbar('Account created successfully', 'Please login to continue');
                    Get.offAllNamed('/login');
                    }
                    
                  },
                  child: Text('Register', style: TextStyle(color: Colors.white, fontSize: 11.sp),),
                ),
              ),
            ],
          ),
        ),
      ),
    );}}