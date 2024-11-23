import 'package:get/get.dart';

class SidebarController extends GetxController {
  var activeItem = 0.obs;
  var isExtended = false.obs;

  void setActiveItem(int index) {
    activeItem.value = index;
  }

  void toggleSidebar() {
    isExtended.value = !isExtended.value;
  }
}