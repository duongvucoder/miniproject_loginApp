import 'package:flutter/material.dart';
import 'package:miniproject/common/widget/MyButton.dart';
import 'package:miniproject/common/widget/MyTextField.dart';
import 'package:miniproject/common/widget/avatar.dart';
import 'package:miniproject/common/widget/toast_overlay.dart';
import 'package:miniproject/module/login_page/login_screen.dart';
import 'package:miniproject/services/api_service.dart';
import 'package:miniproject/services/user_service.dart';
import 'package:miniproject/util/transition/keyboard.dart';
import 'package:miniproject/util/transition/navigator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final andressController = TextEditingController();
  var notifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
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
        child: Column(
          children: [
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
                      controller: nameController,
                      labelText: 'Name',
                      autoFocus: true,
                      keyboardType: TextInputType.text,
                      onChanged: (_) => validate(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MyTextField(
                      controller: phoneController,
                      labelText: 'PhoneNumber',
                      autoFocus: true,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => validate(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MyTextField(
                      controller: passwordController,
                      labelText: 'PassWord',
                      obscureText: true,
                      autoFocus: true,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => validate(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MyTextField(
                      controller: emailController,
                      labelText: 'Email',
                      autoFocus: true,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => validate(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MyTextField(
                      controller: andressController,
                      labelText: 'Andress',
                      onChanged: (_) => validate(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ValueListenableBuilder<bool>(
                              valueListenable: notifier,
                              builder: (context, value, _) {
                                return MyBottom(
                                  text: 'Register',
                                  onTap: register,
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
          ],
        ),
      ),
    ));
  }

  void register() {
    apiService
        .register(
      phone: phoneController.text,
      password: passwordController.text,
      name: nameController.text,
      email: emailController.text,
      andress: andressController.text,
    )
        .then((value) {
      ToastOverlay(context).showOverlay(messeage: 'Đăng ký thành công');
      navigatorPushAndRemoveUntil(context, const LoginScreen());
    }).catchError((e) {
      ToastOverlay(context).showOverlay(messeage: e.toString());
    });
  }

  void validate() {
    final phone = phoneController.text;
    final password = passwordController.text;
    final name = nameController.text;
    final email = emailController.text;
    final andress = andressController.text;
    if (phone.isNotEmpty &&
        password.isNotEmpty &&
        name.isNotEmpty &&
        email.isNotEmpty &&
        andress.isNotEmpty) {
      notifier.value = true;
    } else {
      notifier.value = false;
    }
  }
}
