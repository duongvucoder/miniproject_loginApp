import 'package:flutter/material.dart';
import 'package:miniproject/common/widget/itemlist_newfeed.dart';
import 'package:miniproject/models/newfeed.dart';
import 'package:miniproject/module/news_feed/bloc/newfeed_bloc.dart';

class ListNewFeed extends StatefulWidget {
  const ListNewFeed({super.key});

  @override
  State<ListNewFeed> createState() => _ListNewFeedState();
}

class _ListNewFeedState extends State<ListNewFeed> {
  late NewfeedBloc bloc;
  @override
  void initState() {
    bloc = NewfeedBloc(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NewFeed>>(
      stream: bloc.streamNewfeed,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          final newfeeds = snapshot.data ?? [];
          return RefreshIndicator(
            onRefresh: () async {
              await bloc.getNewfeeds(isClear: true);
            },
            child: ListView.separated(
                itemBuilder: (context, index) {
                  if (index == newfeeds.length - 1) {
                    bloc.getNewfeeds();
                  }
                  final newfeed = newfeeds[index];
                  return ItemListNewFeed(newFeed: newfeed);
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: newfeeds.length),
          );
        }
        return Container();
      },
    );
  }
}
