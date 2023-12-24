import 'package:flutter/material.dart';
import 'package:jellyfiner/components/item_card.dart';
import 'package:jellyfiner/types/server_config.dart';
import 'package:jellyfiner/utils/custom_colors.dart';

class ItemsList extends StatefulWidget {
  const ItemsList({
    super.key,
    required this.config,
    required this.items,
    required this.onTap,
    this.onLongPress,
    required this.title,
  });

  final String title;
  final ServerConfig config;
  final Future<List> items;
  final Function? onTap;
  final Function? onLongPress;

  @override
  State<StatefulWidget> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 200,
            child: FutureBuilder<List>(
              future: widget.items,
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
                          if (widget.onTap != null) {
                            widget.onTap!(snapshot.data![index]);
                          }
                        },
                        onLongPress: () {
                          if (widget.onLongPress != null) {
                            widget.onLongPress!(snapshot.data![index]);
                          }
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
    );
  }
}
