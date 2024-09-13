import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:library_ui/controllers/auth_provider.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/user.dart';

class Profile extends StatelessWidget {
   Profile({super.key});
  // final controller = Get.find<AuthState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(100),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 50, 
                child: Icon(Icons.person, size: 50,),
              ),
              // Text("${controller.userInfo.id}", style: TextStyle(fontSize: 20),),
              // Text(controller.userInfo.name, style: TextStyle(fontSize: 30),),
              // Text(controller.userInfo.email, style: TextStyle(fontSize: 20),),
              // Text(controller.userInfo.token, style: TextStyle(fontSize: 20),),
              // IconButton(
                // icon: Icon(Icons.delete),
                // onPressed: ()async {
                  // await delete(controller.userInfo.id, controller.userInfo.token).then((value){
                    // if (value['message'] == 'User deleted successfully'){
                      // print('User deleted successfully');
                      //  Navigator.pop(context);
                    // }
                  // });
                 
                // },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}