import 'package:flutter/material.dart';
import 'package:miniproject/module/splash/splash_page.dart';

void main() {
  runApp(const MiniProject());
}

class MiniProject extends StatelessWidget {
  const MiniProject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My app',
      theme: ThemeData(
        primaryColor: Colors.pink,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      //home: const NewfeedPage(),
      //home: const LoginScreen(),
      // home: LeftMenuPage(),
      //home: ProfilePage(),
      // home: LoginScreen(),
      home: const SplastPage(),
    );
  }
}

AppBar buildAppbar({
  required String title,
  required BuildContext context,
  List<Widget>? actions,
  Widget? leading,
}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
    ),
    // centerTitle: false,
    backgroundColor: Colors.blue,
    actions: actions,
    leading: leading,
  );
}
