import 'package:flutter/material.dart';
import 'package:miniproject/models/newfeed.dart';

class ItemListNewFeed extends StatefulWidget {
  const ItemListNewFeed({super.key, required this.newFeed});
  final NewFeed newFeed;
  @override
  State<ItemListNewFeed> createState() => _ItemListNewFeedState();
}

class _ItemListNewFeedState extends State<ItemListNewFeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(112),
                child: Image.network(
                  widget.newFeed.accountPublic?.avatar ?? "",
                  height: 56,
                  width: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const FlutterLogo(),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.newFeed.accountPublic?.name ?? "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.newFeed.createdAt ?? "",
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Text(
                widget.newFeed.isEnable.toString(),
                style: const TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ],
          ),
          const Divider(),
          Text(
            widget.newFeed.title ?? "",
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.newFeed.content ?? "",
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(
            height: 8,
          ),
          // ignore: prefer_is_empty
          if ((widget.newFeed.photos!.length >= 0)) ...{
            itemPhoto(),
          }
        ],
      ),
    );
  }

  Widget itemPhoto() {
    return Center(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 23,
            mainAxisExtent: 150,
            childAspectRatio: 1.5),
        itemBuilder: (context, index) {
          final item = widget.newFeed.photos![index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item,
              height: 56,
              width: 56,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const FlutterLogo(),
                );
              },
            ),
          );
        },
        itemCount: widget.newFeed.photos!.length,
      ),
    );
  }
}
