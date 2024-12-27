import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dartssh2/dartssh2.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:xterm/xterm.dart';
import 'package:fluent_ui/src/controls/surfaces/tooltip.dart' as tt;

class CustomTernimal extends StatelessWidget {
  CustomTernimal({
    super.key,
  });
  Stream<Uint8List>? stdout;
  StreamSink<Uint8List>? stdin;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _connectToSSH(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          Terminal terminal = Terminal();
          stdout?.listen((data) {
            terminal.write(utf8.decode(data));
          });
          terminal.onOutput = (output) {
            stdin?.add(utf8.encode(output));
          };
          // 当异步操作成功完成，获取到SSHClient实例并进行后续操作
          return Column(
            children: [
              CommandBar(
                overflowBehavior: CommandBarOverflowBehavior.noWrap,
                primaryItems: [
                  ..._getCommands(),
                ],
              ),
              Expanded(
                  child: TerminalView(
                terminal,
                theme: TerminalThemes.whiteOnBlack,
              ))
            ],
          );
        }
      },
    );
  }

  Future<void> _connectToSSH() async {
    // final socket = await SSHSocket.connect('39.107.246.131', 2233);
    // var client = SSHClient(
    //   socket,
    //   username: 'ecs-user',
    //   onPasswordRequest: () => 'z12345687?',
    // );
    // final shell = await client.shell();
    // stdout = shell.stdout;
    // stdin = shell.stdin;
  }

  List<CommandBarItem> _getCommands() {
    final items = <CommandBarItem>[
      CommandBarBuilderItem(
        builder: (context, mode, w) => tt.Tooltip(
          message: "Create something new!",
          child: w,
        ),
        wrappedItem: CommandBarButton(
          icon: const Icon(FluentIcons.add),
          label: const Text('New'),
          onPressed: () {},
        ),
      ),
      CommandBarBuilderItem(
        builder: (context, mode, w) => tt.Tooltip(
          message: "Delete what is currently selected!",
          child: w,
        ),
        wrappedItem: CommandBarButton(
          icon: const Icon(FluentIcons.delete),
          label: const Text('Delete'),
          onPressed: () {},
        ),
      ),
      CommandBarButton(
        icon: const Icon(FluentIcons.archive),
        label: const Text('Archive'),
        onPressed: () {},
      ),
      CommandBarButton(
        icon: const Icon(FluentIcons.move),
        label: const Text('Move'),
        onPressed: () {},
      ),
      const CommandBarButton(
        icon: Icon(FluentIcons.cancel),
        label: Text('Disabled'),
        onPressed: null,
      ),
    ];
    return items;
  }
}
