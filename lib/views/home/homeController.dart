import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController {
  RxInt navIndex = 0.obs;
  RxInt tabIndex = 0.obs;
  RxList<Tab> tabs = RxList();
}
