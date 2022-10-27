// ignore_for_file: unnecessary_const, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:miniproject/common/widget/share_preference_manager.dart';
import 'package:miniproject/module/login_page/login_screen.dart';
import 'package:miniproject/util/transition/navigator.dart';

class SplastPage extends StatefulWidget {
  const SplastPage({super.key});

  @override
  State<SplastPage> createState() => _SplastPageState();
}

class _SplastPageState extends State<SplastPage> {
  @override
  void initState() {
    inintData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: const Center(
        child: const FlutterLogo(
          size: 100,
        ),
      ),
    );
  }

  Future inintData() async {
    await sharedPrefs.innit();
    navigatorPushAndRemoveUntil(context, const LoginScreen());
  }
}
