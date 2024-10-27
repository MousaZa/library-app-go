import 'dart:math';

import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:choice/inline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/views/books/add_book_page.dart';
import 'package:library_ui/views/books/books_page.dart';
import 'package:library_ui/views/books/books_view.dart';
import 'package:library_ui/views/notifications/notification_card.dart';
import 'package:library_ui/views/sidebar_item.dart';
import 'package:library_ui/views/users/profile.dart';
import 'package:badges/badges.dart' as badges;
import 'package:library_ui/views/users_list.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:sizer/sizer.dart';

class MyHomePage extends StatefulWidget {
  factory MyHomePage.withAuth(String paseto) {
    return MyHomePage(
      paseto: paseto,
    );
  }

  final String paseto;

  final List<Widget> pages = [
    BooksPage(),
    Profile(),
    UsersList(),
  ];

  MyHomePage({super.key, required this.paseto});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool ext = false;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: storage.read(key: "role"),
        builder: (context, snapshot1) {
          if (snapshot1.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
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
                floatingActionButton: snapshot1.data == "user"
                    ? null
                    : FloatingActionButton(
                        backgroundColor: MyColors.green,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddBookPage()));
                        },
                        child: Icon(Icons.add),
                      ),
                body: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: StatefulBuilder(builder: (context, setstate) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            width: ext ? 8.w : 4.w,
                            child: SidebarX(
                              toggleButtonBuilder: (context, extended) {
                                return IconButton(
                                    onPressed: () {
                                      setstate(() {
                                        ext = !ext;
                                      });
                                    },
                                    icon: ext
                                        ? Icon(Icons.arrow_back_ios_outlined)
                                        : Icon(
                                            Icons.arrow_forward_ios_outlined));
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
                              footerItems: [
                                SidebarXItem(onTap: () {
                                  storage.delete(key: "paseto");
                                  Get.offAllNamed('/login');
                                }, iconBuilder: (selected, _) {
                                  return SidebarItem(
                                    ext: ext,
                                    icon: Icons.logout_outlined,
                                    title: "Logout",
                                    isActive: false,
                                  );
                                })
                              ],
                              controller: SidebarXController(selectedIndex: 0),
                              items: [
                                SidebarXItem(onTap: () {
                                  setState(() {
                                    index = 0;
                                  });
                                }, iconBuilder: (__, _) {
                                  return SidebarItem(
                                    ext: ext,
                                    icon: Icons.book_outlined,
                                    title: "Library",
                                    isActive: index == 0,
                                  );
                                }),
                                // SidebarXItem(
                                //   onTap: () {
                                //     setState(() {
                                //       index = 1 ;
                                //     });
                                //   },
                                //   iconBuilder:(selected,_){

                                //   return SidebarItem(ext: ext,icon: Icons.person_outline,title: "Profile",isActive: index == 1,);
                                //   } ),
                                snapshot1.data == "user"
                                    ? SidebarXItem(onTap: () {
                                        setState(() {
                                          index = 1;
                                        });
                                      }, iconBuilder: (selected, _) {
                                        return SidebarItem(
                                          ext: ext,
                                          icon: Icons.person_outline,
                                          title: "Profile",
                                          isActive: index == 1,
                                        );
                                      })
                                    : SidebarXItem(onTap: () {
                                        setState(() {
                                          index = 2;
                                        });
                                      }, iconBuilder: (selected, _) {
                                        return SidebarItem(
                                          ext: ext,
                                          icon: Icons.group_outlined,
                                          title: "Users",
                                          isActive: index == 2,
                                        );
                                      }),
                              ],
                            ),
                          );
                        })),
                    Expanded(
                      child: widget.pages[index],
                    ),
                  ],
                ));
          }
        });
  }
}
