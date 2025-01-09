import 'package:flutter/material.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/views/users/user_avatar.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.userName, required this.email, required this.role, required this.id});
  final String id, userName ;
  final String email;
  final String role;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          UserAvatar(userId: id, size: 2),
          // SizedBox(width: 20),
          Text(userName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Text(email),
          Text(role),
        ],
      ),
    );
  }
}