import 'package:choice/inline.dart';
import 'package:flutter/material.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/views/books/books_view.dart';

class BooksPage extends StatefulWidget {
  BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  final List<String> languages = ["English", "Arabic", "Turkish"];

  final List<String> categories = [
    "Science",
    "Art",
    "Literature",
    "History",
    "Philosophy",
    "Novel",
    "Poetry",
    "Religion",
    "Biography",
    "Fantasy",
    "Mystery",
    "Romance",
    "Thriller",
    "Horror"
  ];

  String searchText = "";

  String language = "";

  String category = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InlineChoice<String>.single(
                            clearable: true,
                            value: language,
                            onChanged: (value) {
                              if (value == null) {
                                value = "";
                              }
                              if (value == language) {
                                value = "";
                              }
                              setState(() {
                                language = value!;
                              });
                            },
                            itemCount: languages.length,
                            itemBuilder: (state, i) {
                              return ChoiceChip(
                                selectedColor: MyColors.lightGreen,
                                selected: state.selected(languages[i]),
                                onSelected: state.onSelected(languages[i]),
                                label: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(languages[i])),
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
                          SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                          ),
                          InlineChoice<String>.single(
                            clearable: true,
                            value: category,
                            onChanged: (value) {
                              if (value == null) {
                                value = "";
                              }
                              if (value == category) {
                                value = "";
                              }
                              setState(() {
                                category = value!;
                              });
                            },
                            itemCount: categories.length,
                            itemBuilder: (state, i) {
                              return ChoiceChip(
                                selectedColor: MyColors.lightGreen,
                                selected: state.selected(categories[i]),
                                onSelected: state.onSelected(categories[i]),
                                label: Text(categories[i]),
                              );
                            },
                            listBuilder: ChoiceList.createScrollable(
                              direction: Axis.horizontal,
                              spacing: 20,
                              // runSpacing: 10,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: BookFetcher(
                      category: category,
                      language: language,
                      search: searchText,
                    )),
                  ],
                ),
              );
  }
}