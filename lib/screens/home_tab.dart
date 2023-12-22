import 'package:flutter/material.dart';
import 'package:jellyfiner/api/items.dart';
import 'package:jellyfiner/screens/collection_page.dart';
import 'package:jellyfiner/types/server_config.dart';
import 'package:jellyfiner/components/item_card.dart';
import 'package:jellyfiner/utils/custom_colors.dart';

class HomeTab extends StatefulWidget {
  final ServerConfig config;

  const HomeTab({super.key, required this.config});

  @override
  State<StatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  int nb = 0;
  late Future<List> collections;
  late Future<List> resume;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    try {
      collections = ItemApi.getItems(widget.config);
      resume = ItemApi.getResumeItems(widget.config);
    } catch (e) {
      collections = Future.value([]);
      resume = Future.value([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List>(
                future: collections,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ItemCard(
                          item: snapshot.data![index],
                          config: widget.config,
                          isFirst: index == 0,
                          isLast: index == snapshot.data!.length - 1,
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                builder: (context) => CollectionPage(
                                  item: snapshot.data![index],
                                  config: widget.config,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                            "Configuration name already exists, please choose another one"),
                        backgroundColor: CustomColors.red,
                      ),
                    );
                    return const Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return const Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<List>(
                future: resume,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ItemCard(
                          item: snapshot.data![index],
                          config: widget.config,
                          isFirst: index == 0,
                          isLast: index == snapshot.data!.length - 1,
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                builder: (context) => CollectionPage(
                                  item: snapshot.data![index],
                                  config: widget.config,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                            "Configuration name already exists, please choose another one"),
                        backgroundColor: CustomColors.red,
                      ),
                    );
                    return const Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return const Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
