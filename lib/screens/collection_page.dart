import 'package:flutter/material.dart';
import 'package:jellyfiner/api/items.dart';
import 'package:jellyfiner/structs/item.dart';
import 'package:jellyfiner/types/server_config.dart';

class CollectionPage extends StatefulWidget {
  final Item item;
  final ServerConfig config;

  const CollectionPage({super.key, required this.item, required this.config});

  @override
  State<StatefulWidget> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  void initState() {
    super.initState();
    ItemApi.getCollectionItems(widget.config, widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(widget.item.getName),
          ],
        ),
      ),
    );
  }
}
