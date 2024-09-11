import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:choice/inline.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/models/book.dart';
import 'package:library_ui/views/add_book_page.dart';
import 'package:library_ui/views/book_card.dart';
import 'package:library_ui/views/login.dart';
import 'package:library_ui/views/register.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return Scaffold(
        appBar: AppBar(
          title: AnimatedSearchBar(
            label: "Library UI",
            onChanged: (value) {
              // debugPrint("value on Change");
              setState(() {
                searchText = value;
              });
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.login),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.app_registration_rounded),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddBookPage()));
          },
          child: Icon(Icons.add),
        ),
        body: Padding(
            padding: EdgeInsets.all(20),
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
                            selected: state.selected(languages[i]),
                            onSelected: state.onSelected(languages[i]),
                            label: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
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
                  child: FutureBuilder(
                      future: getBooks(searchText, language, category),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return DynamicHeightGridView(
                            builder: (context, index) {
                              return BookCard(
                                  bookData:
                                      Book.fromJson(snapshot.data[index]));
                            },
                            itemCount: snapshot.data.length,
                            crossAxisCount: 2,
                          );
                        }
                      }),
                ),
              ],
            )));
  }
}
