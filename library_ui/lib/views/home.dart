import 'dart:math';

import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:choice/inline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/views/books/add_book_page.dart';
import 'package:library_ui/views/books/books_view.dart';
import 'package:library_ui/views/notifications/notification_card.dart';
import 'package:library_ui/views/users/profile.dart';
import 'package:badges/badges.dart' as badges;
import 'package:sidebarx/sidebarx.dart';
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
  bool ext = false;
  int index = 0 ;
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
    return FutureBuilder(future: storage.read(key: "role"), builder: (context,snapshot1){
      if(snapshot1.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }
      else{
      return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: MyColors.green,
        //   foregroundColor: Colors.black,
        //   actions: [
        //     FutureBuilder(
        //         future: getNotifications(),
        //         builder: (context, snapshot) {
        //           if (snapshot.hasData) {
        //             int length = 0;
        //             for (var notification in snapshot.data!) {
        //               if (notification["status"] == "unread") {
        //                 length++;
        //               }
        //             }
        //             if (length > 0) {
        //               return badges.Badge(
        //                 badgeContent: Text(
        //                   length.toString(),
        //                   style: TextStyle(color: Colors.white),
        //                 ),
        //                 child: IconButton(
        //                   onPressed: () {
        //                     Get.defaultDialog(
        //                       title: "Notifications",
        //                       content: Container(
        //                         height: 50.h,
        //                         width: 50.w,
        //                         child: ListView.builder(
        //                           itemCount: snapshot.data!.length,
        //                           itemBuilder: (context, index) {
        //                             markAsRead(snapshot.data![index]["Id"]);
        //                             return NotificationCard(
        //                                 message: snapshot.data![index]
        //                                     ["message"],
        //                                 type: snapshot.data![index]["type"]);
        //                           },
        //                         ),
        //                       ),
        //                     );
        //                   },
        //                   icon: Icon(Icons.notifications),
        //                 ),
        //               );
        //             }
        //           }
        //           return IconButton(
        //             onPressed: () {
        //               Get.defaultDialog(
        //                       title: "Notifications",
        //                       content: Container(
        //                         height: 50.h,
        //                         width: 50.w,
        //                         child: snapshot.data!.length == 0 ? Center(child: Text("You don't have any notifications!"),) : ListView.builder(
        //                           itemCount: snapshot.data!.length,
        //                           itemBuilder: (context, index) {
        //                             markAsRead(snapshot.data![index]["Id"]);
        //                             return NotificationCard(
        //                                 message: snapshot.data![index]
        //                                     ["message"],
        //                                 type: snapshot.data![index]["type"]);
        //                           },
        //                         ),
        //                       ),
        //                     );
        //             },
        //             icon: Icon(Icons.notifications),
        //           );
        //         }),
        //     IconButton(
        //         onPressed: () async {
        //           await getUser(widget.paseto).then((value) {
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) => Profile(userData: value)));
        //           });
        //         },
        //         icon: Icon(Icons.person)),
        //     IconButton(
        //         onPressed: () {
        //           storage.delete(key: "paseto");
        //           Get.offAllNamed('/login');
        //         },
        //         icon: Icon(Icons.logout))
        //   ],
        //   title: AnimatedSearchBar(
        //     label: "Library UI",
        //     onChanged: (value) {
        //       // debugPrint("value on Change");
        //       setState(() {
        //         searchText = value;
        //       });
        //     },
        //   ),
        // ),
        floatingActionButton:snapshot1.data == "user" ? null :FloatingActionButton(
          backgroundColor: MyColors.green,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddBookPage()));
          },
          child: Icon(Icons.add),
        ),
        body: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: StatefulBuilder(builder: (context,setstate){
                return SizedBox(
                width: ext ? 8.w : 4.w,
                child: SidebarX(
                
                  toggleButtonBuilder: (context, extended) {
                    return IconButton(onPressed: (){
                      setstate(() {
                        ext = !ext;
                      });
                    }, icon:ext ? Icon(Icons.arrow_back_ios_outlined) :  Icon(Icons.arrow_forward_ios_outlined));
                  },
                  theme: SidebarXTheme(

                    padding: EdgeInsets.all(.5.w),
                    decoration: BoxDecoration(
                      color: MyColors.lightGreen,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
                    ),
      
                  ),
                        controller: SidebarXController(selectedIndex: 0),
                        items:  [
                          SidebarXItem(
                            onTap: (){
                              setState(() {
                                index = 0 ;
                              });
                            },
                            iconBuilder:(__,_){
                            return ext ? Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Icon(Icons.book_outlined, size: 1.5.w,color: index == 0 ? Colors.black: MyColors.lightBrown,),
                              SizedBox(
                                width: 4.w,
                                child: Center(
                                  child: Text("Library", style: TextStyle(
                                color: index == 0 ? Colors.black: MyColors.lightBrown,
                                fontWeight: FontWeight.bold,
                                 fontSize: 10.sp,

                              ),
                              overflow: TextOverflow.ellipsis,
                              ),
                                ),
                              ),
                            ],) : Center(child: Icon(Icons.book_outlined, size: 1.5.w,color:index == 0 ? Colors.black: MyColors.lightBrown,));
                          } ),
                          SidebarXItem(
                            onTap: () {
                              setState(() {
                                index = 1 ;
                              });
                            },
                            iconBuilder:(selected,_){
          
                            return ext ? Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Icon(Icons.person_outline, size: 1.5.w,color: index == 1 ? Colors.black: MyColors.lightBrown,),
                              SizedBox(
                                width: 4.w,
                                child: Center(
                                  child: Text("Profile",style: TextStyle(
                                color: index == 1 ? Colors.black: MyColors.lightBrown,
                                fontWeight: FontWeight.bold,
                                 fontSize: 10.sp
                              ),
                              overflow: TextOverflow.ellipsis,),
                                ),
                              ),
                            ],) : Center(child: Icon(Icons.person_outline, size: 1.5.w,color: index == 1 ? Colors.black: MyColors.lightBrown,));
                          } ),
                        ],
                      ),
              );
              })),
            Expanded(
              child: index == 1 ? Profile() : Padding(
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
              ),
            ),
          ],
        ));
      }
    });
    }
}
