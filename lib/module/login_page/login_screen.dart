import 'package:flutter/material.dart';
import 'package:miniproject/common/widget/MyButton.dart';
import 'package:miniproject/common/widget/MyTextField.dart';
import 'package:miniproject/common/widget/avatar.dart';
import 'package:miniproject/common/widget/progress_dialog.dart';
import 'package:miniproject/common/widget/share_preference_manager.dart';
import 'package:miniproject/common/widget/toast_overlay.dart';
import 'package:miniproject/module/news_feed/page/newfeed_page.dart';
import 'package:miniproject/module/register_page/register_screen.dart';
import 'package:miniproject/services/api_service.dart';
import 'package:miniproject/services/user_service.dart';
import 'package:miniproject/util/transition/keyboard.dart';
import 'package:miniproject/util/transition/navigator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  var notifier = ValueNotifier<bool>(false);
  late ProgressDialog progress;

  @override
  void initState() {
    progress = ProgressDialog(context);
    sharedPrefs.getString(phoneKey).then((value) {
      phoneController.text = value ?? '';
    });
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: (() {
        hideKeyboardAndUnFocus(context);
      }),
      child: SafeArea(
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 64),
                  const BuildAvart(),
                  const SizedBox(
                    height: 32,
                  ),
                  MyTextField(
                    controller: phoneController,
                    labelText: 'Số điện thoại',
                    autoFocus: true,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => validate(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextField(
                    controller: passwordController,
                    labelText: 'Mật khẩu',
                    obscureText: true,
                    onChanged: (_) => validate(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: register,
                          child: const Text('Register'),
                        ),
                      ),
                      Expanded(
                        child: ValueListenableBuilder<bool>(
                            valueListenable: notifier,
                            builder: (context, value, _) {
                              return MyBottom(
                                text: 'Login',
                                onTap: login,
                                enable: value,
                              );
                            }),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'HotLine:'),
                TextSpan(
                  text: '  1800.1186',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
          ),
        ]),
      ),
    ));
  }

  void register() {
    navigatorPush(context, const RegisterScreen());
  }

  Future login() async {
    progress.show();
    apiService
        .login(phone: phoneController.text, password: passwordController.text)
        .then((user) {
      sharedPrefs.setString(phoneKey, phoneController.text);
      progress.hide();
      ToastOverlay(context).showOverlay(messeage: 'Hello ${user.name}');
      apiService.token = user.token ?? '';
      navigatorPushAndRemoveUntil(context, const NewfeedPage());
    }).catchError((e) {
      progress.show();
      ToastOverlay(context).showOverlay(messeage: e.toString());
    });
  }

  void validate() {
    final phone = phoneController.text;
    final password = passwordController.text;
    if (phone.isNotEmpty && password.isNotEmpty) {
      notifier.value = true;
    } else {
      notifier.value = false;
    }

    // setState(() {});
  }
}
