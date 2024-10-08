import 'package:choice/inline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/models/book.dart';

class EditBookPage extends StatefulWidget {
  EditBookPage({super.key});

  final Book book = Get.arguments;
  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _summaryController = TextEditingController();
  final List<String> languages = ["English", "Arabic", "Turkish"];
  String selectedLanguage = '';
  final List<String> categories = ["Science", "Art", "Literature", "History","Philosophy","Novel","Poetry","Religion","Biography","Fantasy","Mystery","Romance","Thriller","Horror"];
  String selectedCategory = '';
  int borrows = 0;
  int likes = 0;
  int id = 0;

  @override
  void initState() {
    _titleController.text = widget.book.title;
    _authorController.text = widget.book.author;
    _imageUrlController.text = widget.book.coverURL;
    _summaryController.text = widget.book.summary;
    selectedCategory = widget.book.category;
    selectedLanguage = widget.book.language;
    borrows = widget.book.borrows;
    likes = widget.book.likes;
    id = widget.book.id;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book Page'),
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
                    available: true, // todo: fix
                    borrows: borrows,
                    likes: likes,
                    id: id, 
                    author: _authorController.text,
                    title: _titleController.text,
                    coverURL: _imageUrlController.text,
                    category: selectedCategory,
                    language: selectedLanguage,
                    summary: _summaryController.text,
                  ).update();
                  Navigator.pop(context);
                },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Edit Book',style: TextStyle(
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
