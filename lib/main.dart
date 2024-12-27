import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mt;
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:yterm/mainController.dart';
import 'package:yterm/views/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await flutter_acrylic.Window.initialize();
  await WindowManager.instance.ensureInitialized();
  await windowManager.setBrightness(Brightness.dark);
  await windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitleBarStyle(
      TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );
    await windowManager.setMinimumSize(const Size(500, 600));
    await windowManager.setPreventClose(true);
    await windowManager.setSkipTaskbar(false);
    await windowManager.setTitle('title');
    await windowManager.show();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Maincontroller());
    return FluentApp(
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
      theme: FluentThemeData(
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
      home: mt.Scaffold(
        body: const Home(),
        appBar: PreferredSize(
            preferredSize: const Size(double.maxFinite, 50),
            child: DragToMoveArea(
                child: mt.AppBar(
              title: const Text('YOYO'),
              actions: [
                IconButton(
                  onPressed: () => windowManager.minimize(),
                  icon: const Icon(FluentIcons.chrome_minimize),
                ),
                IconButton(
                  onPressed: () => _toggleWindowMax(),
                  icon: Obx(() => controller.isWindowMax.value
                      ? const Icon(FluentIcons.chrome_restore)
                      : const Icon(FluentIcons.checkbox)),
                ),
                IconButton(
                  onPressed: () => windowManager.close(),
                  icon: const Icon(mt.Icons.close),
                ),
              ],
            ))),
      ),
    );
  }

  _toggleWindowMax() {
    var controller = Get.find<Maincontroller>();
    if (controller.isWindowMax.value) {
      windowManager.restore();
    } else {
      windowManager.maximize();
    }
    controller.isWindowMax.value = !controller.isWindowMax.value;
  }
}
