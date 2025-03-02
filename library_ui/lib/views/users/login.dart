import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/controllers/auth.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/views/home.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/views/ofline_page.dart';
import 'package:library_ui/views/users/register.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final controller = Get.put(Auth());
  final _formKey = GlobalKey<FormState>();
  final _passwordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Left side - Login form
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Logo or Icon
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 4.h),
                            width: 20.w,
                            height: 12.h,
                            child: Icon(
                              Icons.menu_book_rounded,
                              size: 80,
                              color: MyColors.brown,
                            ),
                          ),
                        ),
                        
                        // Welcome Text
                       Align(
                        child:  Text(
                          'Welcome back',
                          style: TextStyle(
                            fontSize: 20.sp, 
                            fontWeight: FontWeight.bold,
                            color: MyColors.brown,
                          ),
                        ),
                        alignment: Alignment.center,
                       ),
                        
                        // SizedBox(height: 1.h),
                        
                        // Text(
                        //   'Sign in to continue to Library',
                        //   style: TextStyle(
                        //     fontSize: 12.sp,
                        //     color: Colors.grey[600],
                        //   ),
                        // ),
                        
                        SizedBox(height: 5.h),
                        
                        // Username Field
                        _buildTextField(
                          controller: _usernameController,
                          label: 'Username',
                          prefixIcon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        
                        SizedBox(height: 2.h),
                        
                        // Password Field
                        Obx(() => TextFormField(
                          controller: _passwordController,
                          obscureText: !_passwordVisible.value,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.grey[600]),
                            hintText: 'Enter your password',
                            prefixIcon: Icon(Icons.lock_outline, color: MyColors.brown),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible.value 
                                  ? Icons.visibility 
                                  : Icons.visibility_off,
                                color: MyColors.brown,
                              ),
                              onPressed: () => _passwordVisible.toggle(),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: MyColors.brown, width: 2),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 2.h,
                              horizontal: 2.w,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        )),
                        
                        SizedBox(height: 1.h),
                        
                        // Forgot Password Link
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: TextButton(
                        //     onPressed: () {
                        // TODO: Implement forgot password functionality
                        //     },
                        //     child: Text(
                        //       'Forgot Password?',
                        //       style: TextStyle(
                        //         color: MyColors.brown,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        
                        SizedBox(height: 3.h),
                        
                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: 6.h,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                dynamic paseto = await controller.login(
                                  _usernameController.text, 
                                  _passwordController.text
                                );
                                
                                if (paseto != null && paseto != 'error') {
                                  await storage.write(key: "paseto", value: paseto);
                                  var user = await getUser();
                                  await storage.write(key: "role", value: user['role']);
                                
                                  final notifications = await getNotifications();
                                  if (notifications.isNotEmpty) {
                                    for (var notification in notifications) {
                                      Get.snackbar(
                                        notification['type'],
                                        notification['message'],
                                        icon: notification['type'] == 'warning' 
                                          ? Icon(Icons.warning, color: Colors.white)
                                          : Icon(Icons.info),
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: Theme.of(context).colorScheme.secondary,
                                        colorText: Theme.of(context).colorScheme.onSecondary,
                                      );
                                    }
                                  }
                                  
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyHomePage.withAuth(paseto),
                                    )
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OfflinePage(),
                                    )
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.brown,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 3.h),
                        
                        // Register Link
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 11.sp,
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
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(0, 0),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    color: MyColors.brown,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Right side - Image
          Expanded(
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                image:const  DecorationImage(
                  image: AssetImage('assets/images/background.jpeg'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset:const  Offset(-5, 0),
                  ),
                ],
              ),
              child: Container(
                    color: MyColors.brown.withOpacity(0.2),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        hintText: 'Enter your $label',
        prefixIcon: Icon(prefixIcon, color: MyColors.brown),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: MyColors.brown, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 2.h,
          horizontal: 2.w,
        ),
      ),
      validator: validator,
    );
  }
}