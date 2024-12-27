import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:yterm/views/home/homeController.dart';
import 'package:yterm/views/ternimal/index.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<Homecontroller>();
    controller.tabs.clear();
    controller.tabs.add(Tab(text: Text('data'), body: CustomTernimal()));
    return TabView(
      tabs: controller.tabs,
      currentIndex: controller.tabIndex.value,
      onChanged: (index) => {
        controller.tabIndex.value = index,
      },
      tabWidthBehavior: TabWidthBehavior.equal,
      closeButtonVisibility: CloseButtonVisibilityMode.always,
      showScrollButtons: true,
      onNewPressed: () {},
      onReorder: (oldIndex, newIndex) {},
    );
  }
}
