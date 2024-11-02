import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/home/bloc/home_bloc.dart';
import 'package:library_ui/home/bloc/sidebar_cubit.dart';
import 'package:library_ui/home/view/home.dart';
import 'package:sizer/sizer.dart';

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final bool sidebarState;
  final int index;
  const SidebarItem({
    super.key,
    required this.selected,
    required this.icon,
    required this.label,
    required this.sidebarState, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(vertical: .0),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                    // width: sidebarState ? 4.w : 2.w,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: selected
                          ? MyColors.lightBrown.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Theme(
                    data: ThemeData(
                      iconTheme: IconThemeData(
                        color: selected
                            ? Colors.black
                            : MyColors.brown,
                      ),
                    ),
                    child: sidebarState
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(icon),
                              const SizedBox(width: 10),
                              Text(label, style: TextStyle(
                                color: selected
                                    ? Colors.black
                                    : MyColors.lightBrown,
                                  fontWeight: selected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              ),),
                            ],
                          )
                        : Icon(icon),
                  ),
                ],
              ),
              onTap: () {
                context
                    .read<HomeBloc>()
                    .add(HomeEventChangePage(page: index));
              },
            ),
          ),
        );
      
  }
}
