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
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(Auth());
  final _passwordVisible = false.obs;
  final _confirmPasswordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Left side - Registration form
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
                          child: Text(
                          'Create account',
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
                        //   'Join our library community',
                        //   style: TextStyle(
                        //     fontSize: 12.sp,
                        //     color: Colors.grey[600],
                        //   ),
                        // ),
                        
                        SizedBox(height: 4.h),
                        
                        // Email Field
                        _buildTextField(
                          controller: _emailController,
                          label: 'Email',
                          prefixIcon: Icons.email_outlined,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!GetUtils.isEmail(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        
                        SizedBox(height: 2.h),
                        
                        // Username Field
                        _buildTextField(
                          controller: _usernameController,
                          label: 'Username',
                          prefixIcon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            if (value.length < 3) {
                              return 'Username must be at least 3 characters';
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
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        )),
                        
                        SizedBox(height: 2.h),
                        
                        // Confirm Password Field
                        Obx(() => TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: !_confirmPasswordVisible.value,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(color: Colors.grey[600]),
                            hintText: 'Confirm your password',
                            prefixIcon: Icon(Icons.lock_outline, color: MyColors.brown),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _confirmPasswordVisible.value 
                                  ? Icons.visibility 
                                  : Icons.visibility_off,
                                color: MyColors.brown,
                              ),
                              onPressed: () => _confirmPasswordVisible.toggle(),
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
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        )),
                        
                        // SizedBox(height: 3.h),
                        
                        // // Terms and Conditions Checkbox
                        // Row(
                        //   children: [
                        //     Obx(() => Checkbox(
                        //       value: false.obs.value,
                        //       activeColor: MyColors.brown,
                        //       onChanged: (value) {
                        //         // Implement checkbox state
                        //       },
                        //     )),
                        //     Expanded(
                        //       child: Text(
                        //         'I agree to the Terms of Service and Privacy Policy',
                        //         style: TextStyle(
                        //           fontSize: 10.sp,
                        //           color: Colors.grey[600],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        
                        SizedBox(height: 3.h),
                        
                        // Register Button
                        SizedBox(
                          width: double.infinity,
                          height: 6.h,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final user = await controller.register(
                                  _emailController.text,
                                  _usernameController.text,
                                  _passwordController.text
                                );
                                
                                if (user != 0) {
                                  Get.snackbar(
                                    'Success',
                                    'Account created successfully',
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.TOP,
                                  );
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(
                                      builder: (context) => AddUserAvatar(id: user)
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
                              'Create Account',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 3.h),
                        
                        // Login Link
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 11.sp,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(0, 0),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Log in',
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
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpeg'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: Offset(-5, 0),
                  ),
                ],
              ),
              child: Container(
                    color: MyColors.brown.withOpacity(0.2),
                  ), ),
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