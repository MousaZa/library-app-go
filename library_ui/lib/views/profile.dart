import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:library_ui/controllers/auth_provider.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/models/user.dart';

class Profile extends StatelessWidget {
  final Map<String,dynamic> userData ;
   Profile({super.key, required this.userData});
  // final controller = Get.find<AuthState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 50,  
                child: Icon(Icons.person, size: 50,),
              ),
              Text("${userData["user_id"]}", style: TextStyle(fontSize: 20),),
              Text(userData["username"], style: TextStyle(fontSize: 30),),
              Text(userData["email"], style: TextStyle(fontSize: 20),),
              // Text(, style: TextStyle(fontSize: 20),),
              IconButton(  
                icon: Icon(Icons.delete),
                onPressed: ()async {
                  String? paseto = await storage.read(key: "paseto");
                  await delete(userData["user_id"],paseto! ).then((value){
                    if (value['message'] == 'User deleted successfully'){
                      print('User deleted successfully');
                       Navigator.pop(context);
                    } 
                  });
                 
                },
              ),
            ],
          ),
        )
  );
    }
}