import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jellyfiner/structs/item.dart';
import 'package:jellyfiner/types/server_config.dart';

class ItemCard extends StatefulWidget {
  final Item item;
  final ServerConfig config;
  final bool isFirst;
  final bool isLast;
  final Function? onTap;
  final Function? onLongPress;

  const ItemCard({
    super.key,
    required this.item,
    required this.config,
    required this.isFirst,
    required this.isLast,
    this.onTap,
    this.onLongPress,
  });

  @override
  State<StatefulWidget> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: widget.isFirst ? 10 : 0,
          right: widget.isLast ? 10 : 5,
        ),
        child: InkWell(
          onLongPress: () {
            if (widget.onLongPress != null) widget.onLongPress!();
          },
          onTap: () {
            if (widget.onTap != null) widget.onTap!();
          },
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: widget.item.getImageUrl(widget.config),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: 400,
                height: 225,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
              Text(
                widget.item.seriesName.isNotEmpty
                    ? widget.item.seriesName
                    : widget.item.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
