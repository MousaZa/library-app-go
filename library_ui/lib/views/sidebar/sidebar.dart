import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/controllers/sidebar.dart';
import 'package:library_ui/views/sidebar/sidebar_item.dart';
import 'package:library_ui/views/sidebar/sidebar_toggle.dart';
import 'package:sizer/sizer.dart';

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
                          sidebarState: controller.isExtended.value
                          ),
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