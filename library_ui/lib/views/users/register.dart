import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/controllers/auth.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/views/ofline_page.dart';
import 'package:library_ui/views/users/add_user_avatar.dart';
import 'package:library_ui/views/users/login.dart';
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
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Welcome to Library UI',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: MyColors.brown),
                        focusColor: MyColors.brown,
                        hoverColor: MyColors.brown,
                        fillColor: MyColors.brown,
                        iconColor: MyColors.brown,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.brown),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.brown, style: BorderStyle.solid),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: MyColors.brown),
                        focusColor: MyColors.brown,
                        hoverColor: MyColors.brown,
                        fillColor: MyColors.brown,
                        iconColor: MyColors.brown,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.brown),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.brown, style: BorderStyle.solid),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: MyColors.brown),
                        focusColor: MyColors.brown,
                        hoverColor: MyColors.brown,
                        fillColor: MyColors.brown,
                        iconColor: MyColors.brown,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.brown),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.brown, style: BorderStyle.solid),
                        ),
                      ),
                    ),
                    Container(
                      width: 20.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: MyColors.brown,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          final user = await controller.register(
                              _emailController.text,
                              _usernameController.text,
                              _passwordController.text);
                          if (user != 0) { 
                            Get.snackbar('Account created successfully',
                                'Please login to continue');
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserAvatar(id: user)));
                          }else{
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OfflinePage(),
                            )
                          );
                        }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Login', style: TextStyle(fontSize: 12.sp, color: Colors.black),), 
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
                height: double.infinity,
                child: Image.asset(
                  'assets/images/background.jpeg',
                  fit: BoxFit.fitHeight,
                )),
          )
        ],
      ),
    );
  }
}
