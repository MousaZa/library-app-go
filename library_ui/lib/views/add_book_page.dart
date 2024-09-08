import 'package:flutter/material.dart';
import 'package:library_ui/models/book.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _categoryController = TextEditingController();
  final _LanguageController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book Page'),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Add a new book'),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Author',
                ),
                controller: _authorController,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Image URL',
                ),
                controller: _imageUrlController,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Category',
                ),
                controller: _categoryController,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Language',
                ),
                controller: _LanguageController,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                controller: _descriptionController,
              ),
              MaterialButton(
                onPressed: () async {
                  await Book(
                    borrows: 0,
                    likes: 0,
                    id: 0,
                    author: _authorController.text,
                    title: _titleController.text,
                    coverURL: _imageUrlController.text,
                    category: _categoryController.text,
                    language: _LanguageController.text,
                    summary: _descriptionController.text,
                  ).add();
                  // await Book.add(_titleController.text, _authorController.text, _imageUrlController.text, _categoryController.text, _LanguageController.text, _descriptionController.text);
                  Navigator.pop(context);
                },
                child: Text('Add Book'),
              ),
            ],
          ),
        ),
      ), 
    );
  }
}
