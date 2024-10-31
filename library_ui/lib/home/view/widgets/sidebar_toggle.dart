import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_ui/globals.dart';
import 'package:library_ui/home/bloc/home_bloc.dart';
import 'package:library_ui/home/bloc/sidebar_cubit.dart';

class SidebarToggle extends StatelessWidget {
  final bool sidebarState;

  const SidebarToggle({
    super.key,
    required this.sidebarState,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          // : ButtonStyle(
          //   foregroundColor: WidgetStateProperty.all(
          //       state == index ? Colors.red : Colors.black),
          // ),
          child: Theme(
            data: ThemeData(
              iconTheme: IconThemeData(
                color:Colors.black,
              ),
            ),
            child: Icon(sidebarState ? Icons.arrow_back_ios : Icons.arrow_forward_ios)
          ),
          onTap: () {
            context.read<SidebarCubit>().toggle();
          },
        ),
      ),
    );
  }
}
