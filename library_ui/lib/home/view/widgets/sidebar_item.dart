import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/home/bloc/home_bloc.dart';
import 'package:library_ui/home/bloc/sidebar_cubit.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              child: Theme(
                data: ThemeData(
                  iconTheme: IconThemeData(
                    color: selected
                        ? Colors.black
                        : MyColors.lightBrown,
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
                          ),),
                        ],
                      )
                    : Icon(icon),
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
