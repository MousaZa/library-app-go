import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/controllers/auth.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/views/home.dart';
import 'package:library_ui/globals.dart';

import 'package:library_ui/views/users/register.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final controller = Get.put(Auth());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightBrown.withOpacity(0.1),
      // appBar: AppBar(
      //   title: Text('Login Page'),
      // ),
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Welcome to Library UI',style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        // border: OutlineInputBorder()
                        labelStyle: TextStyle(color: MyColors.brown),
                        focusColor: MyColors.brown,
                        hoverColor: MyColors.brown,
                        fillColor: MyColors.brown,
                        iconColor: MyColors.brown,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.brown),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.brown,style: BorderStyle.solid),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                     decoration: InputDecoration(
                        labelText: 'Password',
                        // border: OutlineInputBorder()
                        labelStyle: TextStyle(color: MyColors.brown),
                        focusColor: MyColors.brown,
                        hoverColor: MyColors.brown,
                        fillColor: MyColors.brown,
                        iconColor: MyColors.brown,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.brown),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.brown,style: BorderStyle.solid),
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
                        onPressed: () async{
                          dynamic paseto = await controller.login(_usernameController.text, _passwordController.text);
                          if ( paseto != null && paseto != 'error' ){
                            await storage.write(key: "paseto", value: paseto);
                            var user = await getUser();
                            print(user);
                            await storage.write(key: "role", value: user['role']);
                          
                          final notifications = await getNotifications();
                          if(notifications.isNotEmpty){
                        for (var notification in notifications) {
                          Get.snackbar(
                            notification['type'],
                            notification['message'],
                            icon: notification['type'] == 'warning' ? Icon(Icons.warning,color: Colors.white,) : Icon(Icons.info),
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                            colorText: Theme.of(context).colorScheme.onSecondary,
                          );}
                          
                        }
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage.withAuth(paseto),
                            )
                          );
                        }
                      },
                        child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 12.sp,),),
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
                      child: Text('Register', style: TextStyle(fontSize: 12.sp, color: Colors.black),), 
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(height:double.infinity,child: Image.asset('assets/images/background.jpeg',fit: BoxFit.fitHeight,)),
          )
        ],
      ),
    );}}