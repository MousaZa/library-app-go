import 'package:flutter/material.dart';
import 'package:library_ui/functions.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.username, required this.email, required this.id, required this.access_token});

  final String username, email, id, access_token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50,),
              ),
              Text(id, style: TextStyle(fontSize: 20),),
              Text(username, style: TextStyle(fontSize: 30),),
              Text(email, style: TextStyle(fontSize: 20),),
              Text(access_token, style: TextStyle(fontSize: 20),),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: ()async {
                  await delete(id, access_token).then((value){
                    if (value['message'] == 'User deleted successfully'){
                      print('User deleted successfully');
                       Navigator.pop(context);
                    }
                  });
                 
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}