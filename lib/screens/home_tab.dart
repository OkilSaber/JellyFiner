import 'package:flutter/material.dart';
import 'package:jellyfiner/api/items.dart';
import 'package:jellyfiner/components/items_list.dart';
import 'package:jellyfiner/screens/collection_page.dart';
import 'package:jellyfiner/types/server_config.dart';

class HomeTab extends StatefulWidget {
  final ServerConfig config;

  const HomeTab({super.key, required this.config});

  @override
  State<StatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int nb = 0;
  late Future<List> collections;
  late Future<List> resume;
  late Future<List> nextUp;
  bool displayResume = false;
  bool displayNextUp = false;

  @override
  void initState() {
    super.initState();
    collections = ItemApi.getItems(widget.config).catchError((e) {
      return [];
    });
    resume = ItemApi.getResumeItems(widget.config).then((value) {
      if (value.isNotEmpty) {
        setState(() => displayResume = true);
      }
      return value;
    }).catchError((e) {
      return [];
    });
    nextUp = ItemApi.getNextUpItems(widget.config).then((value) {
      if (value.isNotEmpty) {
        setState(() => displayNextUp = true);
      }
      return value;
    }).catchError((e) {
      return [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              // Container(
              // height: 300,
              child: ItemsList(
                title: "Collections",
                config: widget.config,
                items: collections,
                onTap: (item) {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (context) => CollectionPage(
                        item: item,
                        config: widget.config,
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Visibility(
                visible: displayResume,
                child: ItemsList(
                  config: widget.config,
                  items: resume,
                  onTap: (item) {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) => CollectionPage(
                          item: item,
                          config: widget.config,
                        ),
                      ),
                    );
                  },
                  title: "Resume",
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: displayNextUp,
                child: ItemsList(
                  title: "Next Up",
                  config: widget.config,
                  items: nextUp,
                  onTap: (item) {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) => CollectionPage(
                          item: item,
                          config: widget.config,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
