import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jellyfiner/api/items.dart';
import 'package:jellyfiner/types/server_config.dart';

class HomeTab extends StatefulWidget {
  final ServerConfig config;

  const HomeTab({super.key, required this.config});

  @override
  State<StatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  int nb = 0;
  late Future<List> items;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    items = ItemApi.getItems(widget.config);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CupertinoPageScaffold(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            ItemApi.getItems(widget.config);
            setState(() => nb++);
            return;
          },
          child: Text(nb.toString()),
        ),
      ),
    );
  }
}
