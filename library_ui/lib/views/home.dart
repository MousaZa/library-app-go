import 'package:flutter/material.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/models/book.dart';
import 'package:library_ui/views/add_book_page.dart';
import 'package:library_ui/views/book_card.dart';
import 'package:library_ui/views/login.dart';
import 'package:library_ui/views/register.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library UI'),
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          IconButton(
            icon: Icon(Icons.app_registration_rounded),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddBookPage()));
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
         child: FutureBuilder(future: getBooks(), builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); 
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length ,
              itemBuilder: (context, index) {
                return BookCard(
                  bookData: Book.fromJson(snapshot.data[index]),
                );});
         }}))
    );
  }
}