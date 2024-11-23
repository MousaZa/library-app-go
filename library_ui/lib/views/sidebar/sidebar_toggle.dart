import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_ui/controllers/sidebar.dart';

// ignore: must_be_immutable
class SidebarToggle extends StatelessWidget {
  final bool sidebarState;

  SidebarToggle({
    super.key,
    required this.sidebarState,
  });

  var controller = Get.find<SidebarController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          child: Theme(
            data: ThemeData(
              iconTheme: IconThemeData(
                color:Colors.black,
              ),
            ),
            child: Icon(sidebarState ? Icons.arrow_back_ios : Icons.arrow_forward_ios)
          ),
          onTap: () {
            controller.toggleSidebar();
          },
        ),
      ),
    );
  }
}