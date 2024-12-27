import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:yterm/views/home/homeController.dart';
import 'package:yterm/views/tabs/index.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Homecontroller());
    List<NavigationPaneItem> items = _getItems(context);
    return NavigationView(
      pane: NavigationPane(
        selected: controller.navIndex.value,
        onItemPressed: (index) {},
        items: items,
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: const Text('data'),
          ),
        ],
      ),
    );
  }

  List<NavigationPaneItem> _getItems(context) {
    List<NavigationPaneItem> items = [
      PaneItem(
          icon: const Icon(FluentIcons.home),
          title: const Text('首页'),
          body: const Tabs(),
          trailing: Row(
            children: [
              Tooltip(
                message: '新增连接',
                child: IconButton(
                    icon: const Icon(FluentIcons.add_connection),
                    onPressed: () => _showAddConn(context)),
              ),
              Tooltip(
                message: '新增文件夹',
                child: IconButton(
                    icon: const Icon(FluentIcons.fabric_new_folder),
                    onPressed: () => _showAddConn(context)),
              ),
            ],
          )),
      PaneItemSeparator(),
      PaneItem(
        icon: const Icon(FluentIcons.issue_tracking),
        title: const Text('Track orders'),
        infoBadge: const InfoBadge(source: Text('8')),
        body: const Tabs(),
      ),
      PaneItem(
        icon: const Icon(FluentIcons.disable_updates),
        title: const Text('Disabled Item'),
        body: const Text('data'),
        enabled: false,
      ),
      PaneItemExpander(
        icon: const Icon(FluentIcons.account_management),
        title: const Text('Account'),
        body: const Text('data'),
        items: [
          PaneItemHeader(header: const Text('Apps')),
          PaneItem(
            icon: const Icon(FluentIcons.mail),
            title: const Text('Mail'),
            body: const Text('data'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.calendar),
            title: const Text('Calendar'),
            body: const Text('data'),
          ),
        ],
      ),
      PaneItemWidgetAdapter(
        child: Builder(builder: (context) {
          if (NavigationView.of(context).displayMode ==
              PaneDisplayMode.compact) {
            return const FlutterLogo();
          }
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200.0),
            child: const Row(children: [
              FlutterLogo(),
              SizedBox(width: 6.0),
              Text('This is a custom widget'),
            ]),
          );
        }),
      ),
    ];
    return items;
  }

  _showAddConn(context) async {
    final _formKey = GlobalKey<FormState>();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('请输入连接信息'),
        content: Form(
          key: _formKey,
          child: Container(
            height: 200,
            child: Column(
              children: [
                TextFormBox(
                  placeholder: '请输入连接名称',
                ),
                const Spacer(),
                TextFormBox(
                  placeholder: '请输入主机地址',
                ),
                const Spacer(),
                TextFormBox(
                  initialValue: '22',
                  placeholder: '请输入端口',
                ),
                const Spacer(),
                TextFormBox(
                  placeholder: '请输入用户名',
                ),
                const Spacer(),
                TextFormBox(
                  placeholder: '请输入密码',
                ),
              ],
            ),
          ),
        ),
        actions: [
          FilledButton(
            child: const Text('取消'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
          Button(
            child: const Text('保存'),
            onPressed: () {
              Navigator.pop(context, 'User deleted file');
            },
          ),
        ],
      ),
    );
  }
}
