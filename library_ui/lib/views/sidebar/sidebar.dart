import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/controllers/sidebar.dart';
import 'package:library_ui/functions.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/views/notifications/notification_card.dart';
import 'package:library_ui/views/sidebar/sidebar_item.dart';
import 'package:badges/badges.dart' as badges;
import 'package:library_ui/views/sidebar/sidebar_toggle.dart';
import 'package:sizer/sizer.dart';
import 'package:star_menu/star_menu.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<SidebarController>(
      init: SidebarController(),
      builder: (controller) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: AnimatedContainer(
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          width: controller.isExtended.value ? 8.w : 4.w,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    StarMenu(
                      params:
                          StarMenuParameters.arc(ArcType.quarterBottomRight),
                      child: CircleAvatar(
                        backgroundColor: MyColors.lightBrown.withOpacity(0.2),
                        foregroundColor: MyColors.brown,
                        radius: 1.w,
                        child: Icon(
                          Icons.person,
                          size: 1.w,
                        ),
                      ),
                      items: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: FutureBuilder(
                              future: getNotifications(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  int length = 0;
                                  for (var notification in snapshot.data!) {
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
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) {
                                                  markAsRead(snapshot
                                                      .data![index]["Id"]);
                                                  return NotificationCard(
                                                      message:
                                                          snapshot.data![index]
                                                              ["message"],
                                                      type:
                                                          snapshot.data![index]
                                                              ["type"]);
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
                                        child: snapshot.data!.length == 0
                                            ? Center(
                                                child: Text(
                                                    "You don't have any notifications!"),
                                              )
                                            : ListView.builder(
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) {
                                                  markAsRead(snapshot
                                                      .data![index]["Id"]);
                                                  return NotificationCard(
                                                      message:
                                                          snapshot.data![index]
                                                              ["message"],
                                                      type:
                                                          snapshot.data![index]
                                                              ["type"]);
                                                },
                                              ),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.notifications),
                                );
                              }),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(Icons.logout_outlined, color: Colors.redAccent,),
                            onPressed: () async {
                              await storage.delete(key: "paseto");
                              Get.offAllNamed('/login');
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    SidebarItem(
                        icon: Icons.book_outlined,
                        label: 'Books',
                        index: 0,
                        selected: controller.activeItem.value == 0,
                        sidebarState: controller.isExtended.value),
                    SidebarItem(
                        icon: Icons.person_outline,
                        label: 'Profile',
                        index: 1,
                        selected: controller.activeItem.value == 1,
                        sidebarState: controller.isExtended.value),
                    SidebarItem(
                        icon: Icons.people_outline,
                        label: 'Users',
                        index: 2,
                        selected: controller.activeItem.value == 2,
                        sidebarState: controller.isExtended.value),
                  ],
                ),
                SidebarToggle(sidebarState: controller.isExtended.value),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
