import 'package:flutter/material.dart';
import 'package:miniproject/common/widget/listnewfeed.dart';
import 'package:miniproject/module/left_menu_page/left_menu_screen.dart';
import 'package:miniproject/main.dart';

class NewfeedPage extends StatefulWidget {
  const NewfeedPage({super.key});

  @override
  State<NewfeedPage> createState() => _NewfeedPageState();
}

class _NewfeedPageState extends State<NewfeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(
        title: 'Sự Cố',
        context: context,
      ),
      drawer: const Drawer(
        child: LeftMenuPage(),
      ),
      body: const ListNewFeed(),
    );
  }
}
