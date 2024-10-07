import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/views/add_book_page.dart';
import 'package:library_ui/views/book_card.dart';
import 'package:library_ui/views/books_view.dart';
import 'package:library_ui/views/notification_card.dart';
import 'package:library_ui/views/profile.dart';
import 'package:badges/badges.dart' as badges;
import 'package:sizer/sizer.dart';

class MyHomePage extends StatefulWidget {
  factory MyHomePage.withAuth(String paseto) {
    return MyHomePage(
      paseto: paseto,
    );
  }

  final String paseto;

  const MyHomePage({super.key, required this.paseto});
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
          actions: [
            FutureBuilder(
                future: getNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int length = 0;
                    for (var notification in snapshot.data) {
                      if (notification["status"] == "unread") {
                        length++;
                      }
                    }
                    if (length > 0) {
                      return badges.Badge(
                        badgeContent: Text(
                          length.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: "Notifications",
                              content: Container(
                                height: 50.h,
                                width: 50.w,
                                child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    markAsRead(snapshot.data[index]["Id"]);
                                    return NotificationCard(
                                        message: snapshot.data[index]
                                            ["message"],
                                        type: snapshot.data[index]["type"]);
                                  },
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.notifications),
                        ),
                      );
                    }
                  }
                  return IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                              title: "Notifications",
                              content: Container(
                                height: 50.h,
                                width: 50.w,
                                child: snapshot.data.length == 0 ? Text("You don't have any notifications!") : ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    markAsRead(snapshot.data[index]["Id"]);
                                    return NotificationCard(
                                        message: snapshot.data[index]
                                            ["message"],
                                        type: snapshot.data[index]["type"]);
                                  },
                                ),
                              ),
                            );
                    },
                    icon: Icon(Icons.notifications),
                  );
                }),
            IconButton(
                onPressed: () async {
                  await getUser(widget.paseto).then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(userData: value)));
                  });
                },
                icon: Icon(Icons.person)),
            IconButton(
                onPressed: () {
                  storage.delete(key: "paseto");
                  Get.offAllNamed('/login');
                },
                icon: Icon(Icons.logout))
          ],
          title: AnimatedSearchBar(
            label: "Library UI",
            onChanged: (value) {
              // debugPrint("value on Change");
              setState(() {
                searchText = value;
              });
            },
          ),
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
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       InlineChoice<String>.single(
                //         clearable: true,
                //         value: language,
                //         onChanged: (value) {
                //           if (value == null) {
                //             value = "";
                //           }
                //           if (value == language) {
                //             value = "";
                //           }
                //           setState(() {
                //             language = value!;
                //           });
                //         },
                //         itemCount: languages.length,
                //         itemBuilder: (state, i) {
                //           return ChoiceChip(
                //             selected: state.selected(languages[i]),
                //             onSelected: state.onSelected(languages[i]),
                //             label: Padding(
                //                 padding:
                //                     EdgeInsets.symmetric(horizontal: 10),
                //                 child: Text(languages[i])),
                //           );
                //         },
                //         listBuilder: ChoiceList.createScrollable(
                //           spacing: 20,
                //           // runSpacing: 10,
                //           padding: const EdgeInsets.symmetric(
                //             horizontal: 20,
                //             vertical: 25,
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         height: 30,
                //         child: VerticalDivider(
                //           color: Colors.black,
                //           thickness: 1,
                //         ),
                //       ),
                //       InlineChoice<String>.single(
                //         clearable: true,
                //         value: category,
                //         onChanged: (value) {
                //           if (value == null) {
                //             value = "";
                //           }
                //           if (value == category) {
                //             value = "";
                //           }
                //           setState(() {
                //             category = value!;
                //           });
                //         },
                //         itemCount: categories.length,
                //         itemBuilder: (state, i) {
                //           return ChoiceChip(
                //             selected: state.selected(categories[i]),
                //             onSelected: state.onSelected(categories[i]),
                //             label: Text(categories[i]),
                //           );
                //         },
                //         listBuilder: ChoiceList.createScrollable(
                //           direction: Axis.horizontal,
                //           spacing: 20,
                //           // runSpacing: 10,
                //           padding: const EdgeInsets.symmetric(
                //             horizontal: 20,
                //             vertical: 25,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Expanded(
                    child: BookFetcher(
                  category: category,
                  language: language,
                  search: searchText,
                )),
              ],
            )));
  }
}
