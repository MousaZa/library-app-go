import 'package:choice/inline.dart';
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
  final _summaryController = TextEditingController();
  final List<String> languages = ["English", "Arabic", "Turkish"];
  String selectedLanguage = '';
  final List<String> categories = ["Science", "Art", "Literature", "History","Philosophy","Novel","Poetry","Religion","Biography","Fantasy","Mystery","Romance","Thriller","Horror"];
  String selectedCategory = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book Page'),
      ),
      body: Center(
        child: SizedBox(
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
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
              InlineChoice<String>.single(
                clearable: true,
                value: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                itemCount: categories.length,
                itemBuilder: (state, i) {
                  return ChoiceChip(
                    selected: state.selected(categories[i]),
                    onSelected: state.onSelected(categories[i]),
                    label: Text(categories[i]),
                  );
                },
                listBuilder: ChoiceList.createWrapped(
                  spacing: 20,
                  // runSpacing: 10,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                ),
              ),
              InlineChoice<String>.single(
                clearable: true,
                value: selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value!;
                  });
                },
                itemCount: languages.length,
                itemBuilder: (state, i) {
                  return ChoiceChip(
                    selected: state.selected(languages[i]),
                    onSelected: state.onSelected(languages[i]),
                    label: Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text(languages[i])),
                  );
                },
                listBuilder: ChoiceList.createScrollable(
                  spacing: 20,
                  // runSpacing: 10,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Summary',
                ),
                maxLines: 5,
                controller: _summaryController,
              ),
              ElevatedButton(        
                onPressed: () async {
                  await Book(
                    available: true, 
                    borrows: 0,
                    likes: 0,
                    id: 0,
                    author: _authorController.text,
                    title: _titleController.text,
                    coverURL: _imageUrlController.text,
                    category: selectedCategory,
                    language: selectedLanguage,
                    summary: _summaryController.text,
                  ).add();
                  // await Book.add(_titleController.text, _authorController.text, _imageUrlController.text, _categoryController.text, _LanguageController.text, _descriptionController.text);
                  Navigator.pop(context);
                },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Add Book',style: TextStyle(
                    fontSize: 20,
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
