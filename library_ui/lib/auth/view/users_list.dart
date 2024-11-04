import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_ui/auth/auth.dart';
import 'package:library_ui/globals.dart';
import 'package:http/http.dart' as http;
import 'package:library_ui/auth/view/widgets/user_card.dart';

Future listUsers(String token) async {
  try {

    http.Response response = await http.get(
      Uri.parse('http://localhost/auth/list/users'),
      // headers: '"Content-Type": "application/json"'
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    if (response.statusCode == 401) {
      print(jsonDecode(response.body));
      return false;
    }
    if (response.statusCode != 200) {
      throw Exception('Failed to get user');
    }
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  } catch (e) {
    print(e);
  }
}

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: listUsers((context.read<AuthBloc>().state as AuthStateAuthenticated).user.token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return UserCard(
                userName: snapshot.data[index]["username"],
                email: snapshot.data[index]["email"],
                role: snapshot.data[index]["role"],
              );
            },
          );
        });
  }
}
