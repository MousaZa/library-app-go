import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_ui/globals.dart';

import 'package:library_ui/home/bloc/sidebar_cubit.dart';
import 'package:library_ui/home/view/widgets/sidebar_item.dart';
import 'package:library_ui/home/view/widgets/sidebar_toggle.dart';
import 'package:sizer/sizer.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SidebarCubit>(
      child: BlocBuilder<SidebarCubit, bool>(builder: (context, state) {
        return Padding(
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
            width: state ? 8.w : 4.w,
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
                          selected: selectedIndex == 0,
                          sidebarState: state),
                      SidebarItem(
                          icon: Icons.person_outline,
                          label: 'Profile',
                          index: 1,
                          selected: selectedIndex == 1,
                          sidebarState: state),
                      SidebarItem(
                          icon: Icons.people_outline,
                          label: 'Users',
                          index: 2,
                          selected: selectedIndex == 2,
                          sidebarState: state),
                    ],
                  ),
                  SidebarToggle(sidebarState: state)
                ],
              ),
            ),
          ),
        );
      }),
      create: (BuildContext context) => SidebarCubit(),
    );
  }
}
